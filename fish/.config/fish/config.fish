###
# https://fishshell.com/docs/current/index.html
# https://github.com/jorgebucaran/cookbook.fish

# themes
# https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md

# Plugins
# https://github.com/jethrokuan/fzf
# https://github.com/IlanCosman/tide.git - fisher install IlanCosman/tide@v5
# https://github.com/jhillyerd/plugin-git

# tools
# https://github.com/jorgebucaran/fisher
# https://github.com/oh-my-fish/oh-my-fish
# https://github.com/danhper/fundle

#set VIRTUAL_ENV_DISABLE_PROMPT "1"

# set LANG
set --export LANG "en_US.UTF-8"

if not status --is-interactive
    exit
end

# Load private config
if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end
if [ -f $HOME/.private ]
    source $HOME/.private
end

# Git
if [ -f $HOME/.config/fish/git.fish ]
    source $HOME/.config/fish/git.fish
end

# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

# reload fish config
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# see my custom section below: it appears better to just use fish_add_path
# https://fishshell.com/docs/current/cmds/fish_add_path.html
# User paths
# set -e fish_user_paths
# set -U fish_user_paths $HOME/.bin $HOME/.local/bin $fish_user_paths

# Starship prompt
#if command -sq starship
#    starship init fish | source
#end

# sets tools
set --export EDITOR nvim
set --export VISUAL nvim
# set --export BROWSER firefox
set --export BROWSER vivaldi-stable

# nvim default config to use
# set --export NVIM_APPNAME nvim-nvchad
set --export NVIM_APPNAME nvim-lazyvim

# Sets the terminal type for proper colors
set --export TERM xterm-256color

# Suppresses fish's intro message
set fish_greeting
#function fish_greeting
#    fish_logo
#end

# Prevent directories names from being shortened
# set fish_prompt_pwd_dir_length 0

# fzf
# set -x FZF_DEFAULT_OPTS "--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up"
setenv FZF_DEFAULT_OPTS "--layout=reverse"

# "bat" as manpager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# colored manpages
# https://blog.yossarian.net/2018/01/22/Reading-Manpages-Like-a-Pro
# https://github.com/jonhoo/configs/blob/master/shell/.config/fish/config.fish
setenv LESS_TERMCAP_mb \e'[01;31m'
setenv LESS_TERMCAP_md \e'[01;31m'
setenv LESS_TERMCAP_me \e'[0m'
setenv LESS_TERMCAP_se \e'[0m'
setenv LESS_TERMCAP_so \e'[1;44;33m'
setenv LESS_TERMCAP_ue \e'[0m'
setenv LESS_TERMCAP_us \e'[1;32m'
setenv GROFF_NO_SGR 1

set -g theme_nerd_fonts yes

if status --is-login
    # set -gx PATH $PATH ~/.bin
    # set -gx PATH $PATH ~/.local/bin
    fish_add_path --global $HOME/.bin
    fish_add_path --global $HOME/.local/bin
end

if type -q bat
    abbr -a -g cat "bat --paging=never"
end

# FZF
# doesnt work
# set -gx FZF_CTRL_T_COMMAND 'bfs -follow \$dir -iname "*" -not -path .git/ -not -path .local/share/Steam/ -not -path .cache/'

if command -sq fzf && type -q fzf_configure_bindings
    set -gx fzf_fd_opts --hidden --no-ignore --exclude=.git --exclude=.cache --exclude target
    fzf_configure_bindings --directory=\ct
end

if not set -q -g fish_user_abbreviations
    set -gx fish_user_abbreviations
end

#if type -f fortune >/dev/null
#  set -l fortune "fortune -a"
#  if type -f lolcat >/dev/null
#    set fortune "$fortune | lolcat"
#  end
#  eval $fortune
#  echo
#end

if which tree >/dev/null
    function l1
        tree --dirsfirst -ChFL 1 $argv
    end
    function l2
        tree --dirsfirst -ChFL 2 $argv
    end
    function l3
        tree --dirsfirst -ChFL 3 $argv
    end
    function ll1
        tree --dirsfirst -ChFupDaL 1 $argv
    end
    function ll2
        tree --dirsfirst -ChFupDaL 2 $argv
    end
    function ll3
        tree --dirsfirst -ChFupDaL 3 $argv
    end
end

if type -q direnv
    eval (direnv hook fish)
end

### FUNCTIONS ###
# Fish command history
function history
    builtin history --show-time='%F %T ' | sort
end

# Make a backup file
function backup --argument filename
    # replace the trailing slash (if any) in the $filename
    set filename (string replace -r '/$' '' $filename)
    cp -r $filename $filename.bak
end

# recently installed packages
function ripp --argument length -d "List the last n (100) packages installed"
    if test -z $length
        set length 100
    end
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $length | nl
end

function gl
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` --bind "ctrl-m:execute: echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R'"
end

function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function less
    command less -R $argv
end

# function cd
#     builtin cd $argv; and ls
# end

### ALIASES ###

## Colorize the grep command output for ease of use (good for log files)##
abbr -a -g grep "grep --color=auto"
abbr -a -g egrep "egrep --color=auto"
abbr -a -g fgrep "fgrep --color=auto"

# Color output of ip
abbr -a -g ip "ip -color"

#readable output
abbr -a -g df "df -h"

##keyboard
#alias give-me-azerty-be="sudo localectl set-x11-keymap be"
#alias give-me-qwerty-us="sudo localectl set-x11-keymap us"

#pacman unlock
abbr -a -g unlock "sudo rm /var/lib/pacman/db.lck"
abbr -a -g rmpacmanlock "sudo rm /var/lib/pacman/db.lck"

#arcolinux logout unlock
abbr -a -g rmlogoutlock "sudo rm /tmp/arcologout.lock"

#which graphical card is working
abbr -a -g whichvga /usr/local/bin/arcolinux-which-vga

#free
abbr -a -g free "free -mt"

#continue download
abbr -a -g wget "wget -c"

#userlist
abbr -a -g userlist "cut -d: -f1 /etc/passwd"

#merge new settings
abbr -a -g merge "xrdb -merge ~/.Xresources"

# Aliases for software managment
# pacman
abbr -a -g update "sudo pacman -Syyu"

# paru as aur helper - updates everything
abbr -a -g upall "paru -Syu --noconfirm"

#ps
abbr -a -g psa "ps auxf"
abbr -a -g psgrep "ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
abbr -a -g update-grub "sudo grub-mkconfig -o /boot/grub/grub.cfg"

#add new fonts
abbr -a -g update-fc "sudo fc-cache -fv"

#copy/paste all content of /etc/skel over to home folder - backup of config created - beware
#skel alias has been replaced with a script at /usr/local/bin/skel

#backup contents of /etc/skel to hidden backup folder in home/user
abbr -a -g bupskel "cp -Rf /etc/skel ~/.skel-backup-(date +%Y.%m.%d-%H.%M.%S)"

##copy shell configs
#alias cb="cp /etc/skel/.bashrc ~/.bashrc && echo "Copied.""
#alias cz="cp /etc/skel/.zshrc ~/.zshrc && echo "Copied.""
#alias cf="cp /etc/skel/.config/fish/config.fish ~/.config/fish/config.fish && exec fish"

##switch between bash, zsh and fish
#alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
#alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Done. Now log out.'"
#alias tofish="sudo chsh $USER -s /bin/fish && echo 'Done. Now log out.'"

##switch between lightdm and sddm
#alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
#alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"
#alias toly="sudo pacman -S ly --noconfirm --needed ; sudo systemctl enable ly.service -f ; echo 'Ly is active - reboot now'"
#alias togdm="sudo pacman -S gdm --noconfirm --needed ; sudo systemctl enable gdm.service -f ; echo 'Gdm is active - reboot now'"
#alias tolxdm="sudo pacman -S lxdm --noconfirm --needed ; sudo systemctl enable lxdm.service -f ; echo 'Lxdm is active - reboot now'"

# kill commands
# quickly kill picom
abbr -a -g kpi "killall picom"

#hardware info --short
abbr -a -g hw "hwinfo --short"

#check vulnerabilities microcode
abbr -a -g microcode "grep . /sys/devices/system/cpu/vulnerabilities/*"

##get fastest mirrors in your neighborhood
#alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
#alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
#alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
#alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
##our experimental - best option for the moment
#alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
#alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
#alias ram="rate-mirrors --allow-root --disable-comments arch | sudo tee /etc/pacman.d/mirrorlist"
#alias rams="rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist"

#mounting the folder Public for exchange between host and guest on virtualbox
abbr -a -g vbm "sudo /usr/local/bin/arcolinux-vbox-share"

#youtube download
abbr -a -g yta-aac "yt-dlp --extract-audio --audio-format aac"
abbr -a -g yta-best "yt-dlp --extract-audio --audio-format best"
abbr -a -g yta-flac "yt-dlp --extract-audio --audio-format flac"
abbr -a -g yta-mp3 "yt-dlp --extract-audio --audio-format mp3"
abbr -a -g ytv-best "yt-dlp -f 'bestvideo[ext mp4]+bestaudio[ext m4a]/bestvideo+bestaudio' --merge-output-format mp4"

#Recent Installed Packages
abbr -a -g rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
abbr -a -g riplong "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#iso and version used to install ArcoLinux
abbr -a -g iso "cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

#Cleanup orphaned packages
abbr -a -g cleanup "sudo pacman -Rns (pacman -Qtdq)"

#clear
alias clean="clear; seq 1 (tput cols) | sort -R | sparklines | lolcat"

##search content with ripgrep
#abbr -a -g rg "rg --sort path"

#get the error messages from journalctl
abbr -a -g jctl "journalctl -p 3 -xb"

# nvime for important configuration files
abbr -a -g nvf "$EDITOR ~/.config/fish/config.fish"
abbr -a -g nvt "$EDITOR ~/.tmux.conf"

##reading logs with bat
#alias lcalamares="bat /var/log/Calamares.log"
#alias lpacman="bat /var/log/pacman.log"
#alias lxorg="bat /var/log/Xorg.0.log"
#alias lxorgo="bat /var/log/Xorg.0.log.old"

#gpg
#verify signature for isos
abbr -a -g gpg-check "gpg2 --keyserver-options auto-key-retrieve --verify"
abbr -a -g fix-gpg-check "gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
abbr -a -g gpg-retrieve "gpg2 --keyserver-options auto-key-retrieve --receive-keys"
abbr -a -g fix-gpg-retrieve "gpg2 --keyserver-options auto-key-retrieve --receive-keys"
abbr -a -g fix-keyserver "[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

#fixes
abbr -a -g fix-permissions "sudo chown -R $USER:$USER ~/.config ~/.local"
abbr -a -g keyfix /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g key-fix /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g keys-fix /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g fixkey /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g fixkeys /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g fix-key /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g fix-keys /usr/local/bin/arcolinux-fix-pacman-databases-and-keys
abbr -a -g fix-sddm-config /usr/local/bin/arcolinux-fix-sddm-config
abbr -a -g fix-pacman-conf /usr/local/bin/arcolinux-fix-pacman-conf
abbr -a -g fix-pacman-keyserver /usr/local/bin/arcolinux-fix-pacman-gpg-conf

#maintenance
abbr -a -g big "expac -H M "%m\t%n" | sort -h | nl"
abbr -a -g downgrada "sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"

#hblock (stop tracking with hblock)
#use unhblock to stop using hblock
abbr -a -g unhblock "hblock -S none -D none"

#systeminfo
abbr -a -g probe "sudo -E hw-probe -all -upload"
abbr -a -g sysfailed "systemctl list-units --failed"

#shutdown or reboot
abbr -a -g ssn "sudo shutdown now"
abbr -a -g sr "sudo reboot"

#update betterlockscreen images
abbr -a -g bls "betterlockscreen -u /usr/share/backgrounds/arcolinux/"

#give the list of all installed desktops - xsessions desktops
abbr -a -g xd "ls /usr/share/xsessions"

#arcolinux applications
abbr -a -g att archlinux-tweak-tool
abbr -a -g adt arcolinux-desktop-trasher
abbr -a -g abl arcolinux-betterlockscreen
abbr -a -g agm arcolinux-get-mirrors
abbr -a -g amr arcolinux-mirrorlist-rank-info
abbr -a -g aom arcolinux-osbeck-as-mirror
abbr -a -g ars arcolinux-reflector-simple
abbr -a -g atm arcolinux-tellme
abbr -a -g avs arcolinux-vbox-share
abbr -a -g awa arcolinux-welcome-app

#remove
abbr -a -g rmgitcache "rm -r ~/.cache/git"

#moving your personal files and folders from /personal to ~
function personal
    cp -rf /personal/ ~
    cp -rf /personal/.* ~
end

# git
# using plugin
# omf install https://github.com/jhillyerd/plugin-git
abbr -a -g undopush "git push -f origin HEAD^:master"

# reporting tools - install when not installed
# neofetch
#screenfetch
#alsi
#paleofetch
#fetch
#hfetch
#sfetch
#ufetch
#ufetch-arco | lolcat
#pfetch
#sysinfo
#sysinfo-retro
#cpufetch
#colorscript random

# colors to set or unset

set fish_color_autosuggestion "#969896"
set fish_color_cancel -r
set fish_color_command "#0782DE"
set fish_color_comment "#f0c674"
set fish_color_cwd "#008000"
set fish_color_cwd_root red
set fish_color_end "#b294bb"
set fish_color_error "#fb4934"
set fish_color_escape "#fe8019"
set fish_color_history_current --bold
set fish_color_host "#85AD82"
set fish_color_host_remote yellow
set fish_color_match --background=brblue
set fish_color_normal normal
set fish_color_operator "#fe8019"
set fish_color_param "#81a2be"
set fish_color_quote "#b8bb26"
set fish_color_redirection "#d3869b"
set fish_color_search_match bryellow background=brblack
set fish_color_selection white --bold background=brblack
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path --underline
set fish_pager_color_completion normal
set fish_pager_color_description "#B3A06D" yellow
set fish_pager_color_prefix normal --bold underline
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_progress brwhite --background=cyan
set fish_color_search_match --background="#60AEFF"


# MY ABBREVIATIONS ---------------------------------
source ~/.config/fish/sourced/abbreviations.fish

# map caps to escape
# setxkbmap -option caps:escape

# set keyboard repeat rate
# xset r rate 300 45 

# ssh-agent
# source: https://unix.stackexchange.com/a/132117
# check that we have openssh installed
if type -q ssh-agent
    # set the auth_sock dir based on whether we are running in a desktop or in a docker container
    if set -q XDG_RUNTIME_DIR
        setenv SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    else
        setenv SSH_AUTH_SOCK "/tmp/ssh-agent.socket"
    end

    ssh-add -l >/dev/null 2>&1
    if test $status -ge 2
        echo "starting ssh-agent"
        ssh-agent -a $SSH_AUTH_SOCK >/dev/null
    end
end

# user paths
fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.local/gobin
fish_add_path $HOME/.cargo/bin
# fish_add_path $HOME/Applications/bear/bin
fish_add_path $HOME/Applications/aflplusplus/bin
fish_add_path $HOME/Applications/aflplusplus/usr/local/bin
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/Applications/ghidra
# fish_add_path $HOME/Applications/llvm-13-release/bin
# fish_add_path /usr/lib/llvm-13/bin
fish_add_path $HOME/code/applications/codeql-home/codeql

# custom env vars
set --export FUZZERR_PROJ_DIR $HOME/code/research/FuzzERR
set --export FUZZERR_AFLPLUSPLUS_DIR $HOME/code/research/FuzzERR_AFLplusplus

# c and c++ compilers - clang
set --export CC clang
set --export CXX clang++

# asdf-vm
test -e ~/.asdf/asdf.fish; and source ~/.asdf/asdf.fish

# set colorterm to get helix to work
setenv COLORTERM truecolor

# rust
setenv RUST_BACKTRACE 1
setenv RUSTC_LOG_COLOR always
# source: @jonhoo config
# if test -e ~/.cargo-target
#     setenv CARGO_TARGET_DIR ~/.cargo-target
# end

# purs3lab stuff (start) >>>>>

# setenv RUSTUP_HOME /home/shank/.rustup
# setenv CARGO_HOME /home/shank/.cargo
# fish_add_path $CARGO_HOME/bin

# purs3lab stuff (end) <<<<<

# bat light theme
setenv BAT_THEME Coldark-Dark

# nix
if [ -f $HOME/.nix-profile/bin ]
    setenv NIXPKGS_ALLOW_UNFREE 1
    fish_add_path $HOME/.nix-profile/bin
    set --export XDG_DATA_DIRS $HOME/.nix-profile/share:$XDG_DATA_DIRS
end

# load zoxide
abbr -a -g cd z
zoxide init fish | source
