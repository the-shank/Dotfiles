function y720pl -d "youtube-dl playlist at 720p"
    youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s" $argv
end
