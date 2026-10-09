function jjd -d "review a jj revision side-by-side in nvim, one tab per changed file"
    argparse 'r=' -- $argv; or return
    set -q _flag_r; or set _flag_r @

    # ==========================================================================
    # Pin the revision
    # ==========================================================================

    # The revision is resolved once. A symbol such as `@` can point at a
    # different commit by the time nvim exits, so every later read uses the
    # commit id, and saved edits are applied through the change id.
    set resolved (jj log --no-graph -r $_flag_r -T 'change_id ++ " " ++ commit_id ++ " " ++ immutable ++ "\n"'); or return
    if test (count $resolved) -ne 1
        echo "jjd: '$_flag_r' must resolve to exactly one revision"
        return 1
    end
    echo $resolved | read -l change commit immutable

    # Paths are relative to the repo root, not to the current directory, so
    # that the temp dir below mirrors the repo layout. `jj diffedit` expects
    # that layout when the saved edits are handed to it.
    #
    # The `jj log` above has already snapshotted the working copy, so the
    # remaining reads skip that step.
    set root (jj root)
    set files (jj diff --ignore-working-copy -r $commit -T 'path ++ "\n"' $argv); or return
    if test (count $files) -eq 0
        echo "no changed files match"
        return 1
    end

    # ==========================================================================
    # Build the nvim session
    # ==========================================================================

    # Both sides are written to a temp dir because neither is the working
    # copy: the right side is the file as of the revision, the left side is
    # the file as of its parent.
    #
    # The nvim commands go into a script instead of `-c` arguments because nvim
    # accepts at most 10 of those, which a revision touching more files exceeds.
    set tmp (mktemp -d -t "jjd.XXXXXX")
    set script $tmp/review.vim

    echo '
" Each file is a tab here, but all of their buffers share one buffer list.
" Cycling buffers inside a diff pane would swap in a buffer of some other
" file and diff two unrelated files. So the buffer-cycling keys switch tabs
" instead while in these buffers.
function s:TabKeys()
  nnoremap <buffer> <S-h> <Cmd>tabprevious<CR>
  nnoremap <buffer> <S-l> <Cmd>tabnext<CR>
  nnoremap <buffer> [b <Cmd>tabprevious<CR>
  nnoremap <buffer> ]b <Cmd>tabnext<CR>
endfunction

function s:Open(old, new, real, edited, editable)
  " Both files are read without autocommands and turned into scratch buffers
  " before their filetype is set. This way no language server attaches to a
  " temp file that belongs to no project.
  "
  " They are read with `:edit` so that the buffer picks up the line endings,
  " and whether the last line ends in a newline, and saves them back as is.
  tabnew
  execute "noautocmd edit" fnameescape(a:new)

  " The right side is named after the real file, so that copying the buffer
  " path yields a path that exists in the repo instead of a temp path. Being a
  " scratch buffer, it cannot be written back over the real file, whose
  " content may be newer than that of the revision.
  "
  " Saving an editable right side writes the buffer to the path in `edited`.
  " Those files are put into the revision once nvim exits.
  if a:editable
    setlocal buftype=acwrite
    let b:jjd_edited = a:edited
    autocmd BufWriteCmd <buffer> execute "silent keepalt write!" fnameescape(b:jjd_edited) | setlocal nomodified
  else
    setlocal buftype=nofile nomodifiable
  endif
  execute "silent keepalt file" fnameescape(a:real)
  filetype detect
  call s:TabKeys()

  " Only the right side stays listed. That makes the bufferline show one
  " entry per changed file, in tab order, instead of each file twice.
  execute "noautocmd leftabove vert diffsplit" fnameescape(a:old)
  setlocal buftype=nofile nomodifiable nobuflisted
  filetype detect
  call s:TabKeys()
  wincmd p
endfunction
' >$script

    for f in $files
        mkdir -p $tmp/old/(dirname $f) $tmp/new/(dirname $f) $tmp/edited/(dirname $f)
        set fileset 'root-file:"'(string replace -a '\\' '\\\\' -- $f | string replace -a '"' '\\"')'"'

        # A file added or deleted by the revision is missing on one side.
        # The failed `file show` leaves an empty file, which diffs correctly.
        jj file show --ignore-working-copy -r "$commit-" $fileset >$tmp/old/$f 2>/dev/null
        jj file show --ignore-working-copy -r $commit $fileset >$tmp/new/$f 2>/dev/null
        set in_revision $status

        # The right side is editable only if jj allows rewriting the revision.
        # A file deleted by the revision stays read-only: saving its empty
        # buffer would bring the file back as an empty file.
        set editable 0
        if test $immutable = false -a $in_revision -eq 0
            set editable 1
        end

        # Paths are passed as vim string literals, in which a quote is doubled.
        set q (string replace -a "'" "''" -- $tmp/old/$f $tmp/new/$f $root/$f $tmp/edited/$f)
        echo "call s:Open('$q[1]', '$q[2]', '$q[3]', '$q[4]', $editable)" >>$script
    end

    # nvim starts with an empty tab holding an empty listed buffer. It is
    # wiped along with its tab so that it does not show up in the bufferline.
    echo "tabfirst | setlocal bufhidden=wipe | tabclose" >>$script

    nvim -S $script
    set nvim_status $status

    # ==========================================================================
    # Put saved edits into the revision
    # ==========================================================================

    # Leaving nvim with `:cq` exits non-zero, which discards any saved edits.
    set edited (find $tmp/edited -type f)
    if test $nvim_status -ne 0; or not set -q edited[1]
        rm -r -- $tmp
        return
    end

    # A saved file replaces the whole file in the revision. If that file has
    # changed in the revision since it was loaded, replacing it would silently
    # drop that change, so nothing is applied and the saved files are kept.
    set now (jj log --no-graph -r $change -T 'commit_id ++ "\n"' 2>/dev/null)
    if test (count $now) -ne 1
        echo "jjd: change $change no longer resolves to one revision; saved edits kept in $tmp/edited"
        return 1
    end
    for e in $edited
        set f (string replace -- $tmp/edited/ "" $e)
        set fileset 'root-file:"'(string replace -a '\\' '\\\\' -- $f | string replace -a '"' '\\"')'"'
        if not jj file show --ignore-working-copy -r $now $fileset 2>/dev/null | cmp -s - $tmp/new/$f
            echo "jjd: $f changed in the revision during the session; saved edits kept in $tmp/edited"
            return 1
        end
    end

    # `jj diffedit` hands its diff editor a directory holding the revision's
    # files and takes whatever the editor leaves there as the revision's new
    # content. Copying the saved files over it rewrites the revision and
    # rebases its descendants.
    if not jj diffedit -r $now --config "ui.diff-editor=[\"cp\", \"-rT\", \"$tmp/edited\", \"\$right\"]"
        echo "jjd: could not apply the edits; saved edits kept in $tmp/edited"
        return 1
    end
    rm -r -- $tmp
    # TODO: merge revisions are not supported: `commit-` resolves to several
    # parents, so the left side comes up empty.
end
