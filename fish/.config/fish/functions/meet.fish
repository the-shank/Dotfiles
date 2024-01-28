function meet -d "add a meeting note"
    set meeting_dir "$HOME/Sync/MyBrain/meeting_notes"
    mkdir -p $meeting_dir
    set d (date -u '+%Y-%m-%d')
    set file "$meeting_dir/$d $argv.md"
    nvim $file
    echo "edited $file"
end
