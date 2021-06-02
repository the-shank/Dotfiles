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
    fd
    fish
    fzf
    htop
    lf-bin
    ranger
    )

dev=(
    ctags
    coreutils
    bat
    base-devel
    clang
    docker
    docker-compose
    )

desktop_base=(
    acpilight
    arc-gtk-theme
    kvantummanager
    languagetool
    )

desktop_full=(
    flameshot
    anki
    calibre
    chromium
    enpass-bin
    evince
    gnome-sound-recorder
    handbrake
    jpegoptim
    )

base_packages=(
    # libreoffice
    # megasync ??
    mpv
    ncdu
    neofetch
    nerd-fonts-noto-sans-mono
    pdfarranger
    powerline-fonts
    qbittorrent
    qt5ct
    # redshift
    ripgrep
    rustup
    # simplescreenrecorder
    # sshpass
    tealdeer
    tmux
    # tokei
    # udftools
    # youtube-dl
)
