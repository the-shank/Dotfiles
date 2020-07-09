function y1080 -d "youtube-dl at 1080p"
    youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" $argv
end
