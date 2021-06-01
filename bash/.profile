# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# add gobin & gopath to PATH if it exists
[ -d "$HOME/.local/gobin" ] && export GOBIN="$HOME/.local/gobin" && PATH="$PATH:$GOBIN"
[ -d "$HOME/code/go" ] && export GOPATH="$HOME/code/go"

# set PATH to include ~/.mix and ~/.mix/escripts
[ -d "$HOME/.mix" ] && PATH="$HOME/.mix:$PATH"
[ -d "$HOME/.mix/escripts" ] && PATH="$HOME/.mix/escripts:$PATH"

# rust: cargo
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# rust: enable backtrace
export RUST_BACKTRACE=full

# set PATH so it includes user's Android Studio bin if it exists
[ -d "$HOME/Applications/android-studio/bin" ] && PATH="$HOME/Applications/android-studio/bin:$PATH"

# notify when commands complete in the terminal
[ -f "/usr/share/undistract-me/long-running.bash" ] && source /usr/share/undistract-me/long-running.bash

# ansible-galaxy
[ -d "$HOME/code/utils/ansible-roles" ] && export ansible_roles_path="$HOME/code/utils/ansible-roles"

# Java
[ -d "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home" ] && export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home

# Apache Derby
export DERBY_INSTALL="$HOME/Applications/db-derby-10.15.1.3-bin"
[ -d "$DERBY_INSTALL/bin" ] && export PATH="$PATH:$DERBY_INSTALL/bin"
[ -d "$DERBY_INSTALL/lib" ] && export CLASSPATH="$DERBY_INSTALL/lib/*"

# SimpleDB
export SIMPLEDB_HOME="$HOME/Applications/SimpleDB_2.10"
[ -d "$SIMPLEDB_HOME" ] && export CLASSPATH=".:$SIMPLEDB_HOME/bin:$CLASSPATH"

# Homebrew
[ -d "/usr/local/sbin" ] && export PATH="/usr/local/sbin:$PATH"

# autojump
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh
[ -f /etc/profile.d/autojump.sh ] && . /etc/profile.d/autojump.sh

# fasd
if hash fasd 2>/dev/null; then
    eval "$(fasd --init auto)"
fi

# editor
if hash nvim 2>/dev/null; then
    export GIT_EDITOR=nvim
    export EDITOR=nvim
elif hash mousepad 2>/dev/null; then
    export GIT_EDITOR=mousepad
    export EDITOR=mousepad
elif hash subl 2>/dev/null; then
    export GIT_EDITOR="subl -w"
    export EDITOR="subl -w"
fi

# fix shader stuttering on AMD GPU
export RADV_PERFTEST=aco

# bat (replacement for cat)
export BAT_THEME="base16"

# enable downgrading packages in Manjaro
export DOWNGRADE_FROM_ALA=1

# fzf
export FZF_DEFAULT_COMMAND='fd --hidden --ignore-case --follow --exclude .git/ ""'

# map caps lock to escape
setxkbmap -option caps:escape

# llvm
[ -d /usr/local/opt/llvm/bin ] && export PATH="/usr/local/opt/llvm/bin:$PATH"
[ -d /usr/local/opt/llvm/lib ] && export LDFLAGS="-L/usr/local/opt/llvm/lib"
[ -d /usr/local/opt/llvm/include ] && export CPPFLAGS="-I/usr/local/opt/llvm/include"

# ssh-agent
# https://unix.stackexchange.com/a/132117
test -d $XDG_RUNTIME_DIR && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add -l >/dev/null 2>&1
[ $? -ge 2 ] && \
    echo "starting ssh-agent" && \
    ssh-agent -a $SSH_AUTH_SOCK >/dev/null

# in case there is a .private file, source it
[ -f $HOME/.private ] && source "$HOME/.private"

# enable vi mode
set -o vi

# default web browser
export BROWSER=/usr/bin/firefox

# from manjaro-i3's .profile
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# default terminal
export TERMINAL=/usr/bin/xfce4-terminal
