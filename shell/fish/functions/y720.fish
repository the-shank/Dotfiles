function y720 -d "youtube-dl at 720p"
    youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" $argv
end
