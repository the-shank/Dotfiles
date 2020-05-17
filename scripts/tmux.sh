#!/bin/bash

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo 'Installing tmux plugin manager'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "tmux plugin manager already installed"
fi
