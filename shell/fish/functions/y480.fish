function y480 -d "youtube-dl at 480p"
    youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]" $argv
end
