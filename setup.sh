#!/usr/bin/env bash

################################################################################
############################          Flow          ############################
################################################################################

# 0. Create common directories
# 1. Detect the OS
# 2. Install common packages
# 3. Install OS specific packages

################################################################################
################          0. Create common directories          ################
################################################################################

base_directories=(
    ~/Applications
    ~/code
    ~/code/algo
    ~/code/reference
    ~/code/tmp
    ~/code/utils
    ~/code/go
    ~/code/go/src
    ~/code/go/pkg
    ~/.local/bin
    ~/.local/gobin
)

function create_base_dirs() {
    for dir in "${base_directories[@]}"
    do
        echo "creating $dir"
        mkdir -p $dir
    done
}

create_base_dirs


################################################################################
######################          1. Detect the OS          ######################
################################################################################

# TODO


################################################################################
#################          2. Install common packages          #################
################################################################################

# TODO

###############################################################################
##############          3. Install OS specific packages          ##############
###############################################################################

# TODO

base=(
    choose
    fd
    fish
    fzf
    htop
    lf-bin
    ncdu
    ranger
    ripgrep
)

dev=(
    base-devel
    bat
    clang
    coreutils
    ctags
    docker
    docker-compose
    mycli
    neofetch
    rm-improved
    rustup
    sshpass
    tealdeer
    tmux
    tokei
)

desktop_base=(
    acpilight
    arc-gtk-theme
    espanso
    kvantummanager
    languagetool
    nerd-fonts-noto-sans-mono
    qbittorrent
    qt5ct
    starship
)

desktop_full=(
    anki
    calibre
    chromium
    dict-wn
    dictd
    enpass-bin
    evince
    flameshot
    gnome-sound-recorder
    handbrake
    jpegoptim
    libreoffice
    megasync-bin
    mpv
    obsidian
    pdfarranger
    powerline-fonts
    redshift
    simplescreenrecorder
    udftools
    xfce4-dict
    youtube-dl
)
