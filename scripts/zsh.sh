#!/bin/bash

. ~/dotfiles/scripts/utils.sh
detect_os

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
    echo 'Installing oh-my-zsh'
    /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "Oh-my-zsh already installed"
fi

# Change default shell
if [[ ! $SHELL = *zsh ]]; then
    echo 'Changing default shell to zsh'
    case $OS in
    ubuntu | manjaro)
        chsh -s /usr/bin/zsh
        ;;

    darwin)
        chsh -s /usr/local/bin/zsh
        ;;
    *)
        echo "unsupported os: $OS"
        exit
        ;;
    esac
else
    echo 'Already using zsh'
fi

# ZSH: autosuggestinos
if [ -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions directory already exists"
else
    echo "downloading zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# ZSH: peco history
if [ -e $HOME/.zsh/zsh-peco-history ]; then
    echo "zsh-peco-history directory already exists"
else
    echo "downloading zsh-peco-history"
    git clone https://github.com/jimeh/zsh-peco-history.git ~/.zsh/zsh-peco-history
fi
