function y1080pl -d "youtube-dl playlist at 1080p"
    youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s" $argv
end
