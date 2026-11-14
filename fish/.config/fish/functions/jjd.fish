function jjd --description 'Open a jj diff in nvim DiffviewOpen'
    # Usage:
    #   jjd                                         Diff @ in DiffviewOpen
    #   jjd <rev>                                   jj edit <rev>, then diff it in DiffviewOpen
    #   jjd -- <paths...>                           Diff @ for specific paths
    #   jjd <rev> -- <paths...>                     jj edit <rev>, then diff specific paths
    #   jjd --from <rev>                            Diff <rev> against @ (editable right pane)
    #   jjd --from <rev> --to @                     Same as omitting --to
    #   jjd --from <old> --to <new>                 Diff <old>..<new> (both read-only)
    #   jjd --from <rev> [--to <new>] -- <paths...> Limit the --from/--to diff to specific paths

    # Split on -- before argparse so `jjd -- <paths>` is not treated as a positional rev.
    set -l pre_args $argv
    set -l paths
    if set -l sep_idx (contains -i -- -- $argv)
        if test $sep_idx -gt 1
            set pre_args $argv[1..(math $sep_idx - 1)]
        else
            set pre_args
        end
        if test $sep_idx -lt (count $argv)
            set paths $argv[(math $sep_idx + 1)..-1]
        end
    end

    argparse 'from=' 'to=' -- $pre_args; or return

    if set -q _flag_to; and not set -q _flag_from
        echo "jjd: --to requires --from" >&2
        return 1
    end

    if set -q _flag_from
        if set -q argv[1]
            echo "jjd: unexpected argument '$argv[1]' (place file paths after --)" >&2
            return 1
        end

        set -l rev_flags --from
        set -l revsets $_flag_from
        if set -q _flag_to; and test "$_flag_to" != "@"
            set -a rev_flags --to
            set -a revsets $_flag_to
        end

        set -l commit_ids
        for i in (seq (count $revsets))
            set -l id (jj log -r "$revsets[$i]" --no-graph -T 'commit_id ++ "\n"'); or return
            if test (count $id) -ne 1
                echo "jjd: $rev_flags[$i] revset '$revsets[$i]' must resolve to a single commit (got "(count $id)")" >&2
                return 1
            end
            set -a commit_ids $id
        end

        set -l diff_spec (string join .. -- $commit_ids)
        if test (count $paths) -gt 0
            nvim "+DiffviewOpen $diff_spec -- $paths"
        else
            nvim "+DiffviewOpen $diff_spec"
        end
        return
    end

    if test (count $argv) -gt 1
        echo "jjd: unexpected argument '$argv[2]' (place file paths after --)" >&2
        return 1
    end

    # With no argument, @ is already checked out, so there is nothing to edit.
    if set -q argv[1]
        jj edit $argv[1]; or return
    end

    if test (count $paths) -gt 0
        nvim "+DiffviewOpen -- $paths"
    else
        nvim +DiffviewOpen
    end
end
