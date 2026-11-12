function fish_jj_prompt --description 'Write out the jj prompt'
    if not command -sq jj
        return 1
    end

    set -l info "$(
        jj log </dev/null 2>/dev/null --no-graph --ignore-working-copy --color=never --revisions @ \
            --template '
                separate(" ",
                    change_id.shortest(4),
                    bookmarks,
                    if(conflict, "×"),
                    if(empty, "∅"),
                )
            '
    )"
    or return 1

    if test -n "$info"
        printf ' (jj: %s)' $info
    end
end
