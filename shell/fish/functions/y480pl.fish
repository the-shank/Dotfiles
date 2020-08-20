function y480pl -d "youtube-dl playlist at 480p"
    youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s" $argv
end
