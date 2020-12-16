if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# profile
source ~/.config/fish/profile.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# abbreviations
abbr -a vim nvim
abbr -a cat bat
abbr -a lla 'll -a'
abbr -a lsa 'ls -a'
abbr -a r0 'redshift -P -O 6500'
abbr -a r1 'redshift -P -O 6000'
abbr -a r2 'redshift -P -O 5500'
abbr -a r3 'redshift -P -O 5000'
abbr -a r4 'redshift -P -O 4500'
abbr -a r5 'redshift -P -O 4000'
abbr -a rgi 'rg -i'
abbr -a conda_enable 'eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'
abbr -a y480 'youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]"'
abbr -a y480pl 'youtube-dl -f "bestvideo[ext=webm][height<=481]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y720 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]"'
abbr -a y720pl 'youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a y1080 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]"'
abbr -a y1080pl 'youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
abbr -a obs 'obsidian > /dev/null 2&>1 & && disown (jobs -p)'
