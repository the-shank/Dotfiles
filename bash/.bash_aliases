# quick switch dirs
alias ..='cd ..'          # up one
alias ...='cd ../..'      # up two
alias ....='cd ../../..'  # up three (that's enough)
alias cdd='cd -'          # back to previous directory

# quick edits to dotfiles
alias dots='cd ~/dotfiles/ && nvim'
alias aliases='nvim ~/.config/bash_aliases'
alias nvinit='nvim ~/dotfiles/config/nvim/init.vim'

# general
alias mkdirp='mkdir -p'   # auto nesting
alias cpr='cp -R'         # recursive
alias duh='du -h'         # list disk usage for all files in ./
alias dush='du -sh'       # list total disk usage of ./
alias chx='chmod +x'      # make it executable
alias chR='chmod -R'      # recursive
alias e=nvim
alias o=open
alias vim=nvim
if command -v batcat > /dev/null; then
    if ! command -v bat > /dev/null; then
        alias bat=batcat
    fi
fi
alias cat=bat
alias l='ls'
alias ll='ls -l'
alias lll='ls -la'
alias less="less -MNi"    # file info/position, line #'s, smart case
# TODO
# alias conda-enable='eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" | source'

# redshift
alias r0='redshift -P -O 6500'
alias r1='redshift -P -O 6000'
alias r2='redshift -P -O 5500'
alias r3='redshift -P -O 5000'
alias r4='redshift -P -O 4500'
alias r5='redshift -P -O 4000'

# backlight
alias bl='sudo xbacklight -set'
alias bl0='sudo xbacklight -set 0'    # backlight = 0% (minimum)
alias bl5='sudo xbacklight -set 5'    # backlight = 5%
alias bl10='sudo xbacklight -set 10'  # backlight = 10%
alias blinc='sudo xbacklight -inc 2'
alias bldec='sudo xbacklight -dec 2'

# ripgrep
alias rgi='rg --ignore-case'
alias rgil='rg --ignore-case --files-with-matches'
alias rgih='rg --ignore-case --hidden'

# fd
if command -v fdfind > /dev/null; then
    if ! command -v fd > /dev/null; then
        alias fd=fdfind
    fi
fi
alias fdi='fd --ignore-case'
alias fdih='fd --ignore-case --hidden'
alias fdh='fd --hidden'

# youtube-dl
alias y480='youtube-dl -f "bestvideo[ext=webm][height<=480]+bestaudio[ext=webm]"'
alias y480pl='youtube-dl -f "bestvideo[ext=webm][height<=481]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
alias y720='youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]"'
alias y720pl='youtube-dl -f "bestvideo[ext=webm][height<=720]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'
alias y1080='youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]"'
alias y1080pl='youtube-dl -f "bestvideo[ext=webm][height<=1080]+bestaudio[ext=webm]" -o "~/Downloads/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s"'

# delete nvim swp files
alias rmswp="rm -f $HOME/.local/share/nvim/swap/*"

# rust
alias c=cargo
alias ct='cargo t'

# TODO - port fish functions to bash
# is it possible to call fish functions from bash?

# docker
alias d=docker
alias dc='docker container'
alias di='docker image'
