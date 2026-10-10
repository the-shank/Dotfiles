function jjd --description 'jj edit a revision (default @), then open its diff in diffview'
    # With no argument, @ is already checked out, so there is nothing to edit.
    if set -q argv[1]
        jj edit $argv[1]; or return
    end
    nvim +DiffviewOpen
end
