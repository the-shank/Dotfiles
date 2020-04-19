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
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH to include ~/.mix and ~/.mix/escripts
if [ -d "$HOME/.mix" ] ; then
    PATH="$HOME/.mix:$PATH"
fi
if [ -d "$HOME/.mix/escripts" ] ; then
    PATH="$HOME/.mix/escripts:$PATH"
fi

# rust: cargo
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# rust: enable backtrace
export RUST_BACKTRACE=full

# set PATH so it includes user's Android Studio bin if it exists
if [ -d "$HOME/Applications/android-studio/bin" ]; then
    PATH="$HOME/Applications/android-studio/bin:$PATH"
fi

# notify when commands complete in the terminal
if [ -f "/usr/share/undistract-me/long-running.bash" ]; then
    source /usr/share/undistract-me/long-running.bash
fi

# ansible-galaxy
if [ -d "$HOME/Code/UTILS/ANSIBLE-ROLES" ]; then
    export ANSIBLE_ROLES_PATH="$HOME/Code/UTILS/ANSIBLE-ROLES"
fi

# Java
if [ -d "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home" ]; then
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home
fi

# Apache Derby
export DERBY_INSTALL="$HOME/Applications/db-derby-10.15.1.3-bin"
if [ -d "$DERBY_INSTALL/bin" ] ; then
    export PATH="$PATH:$DERBY_INSTALL/bin"
fi
if [ -d "$DERBY_INSTALL/lib" ] ; then
    export CLASSPATH="$DERBY_INSTALL/lib/*"
fi

# SimpleDB
export SIMPLEDB_HOME="$HOME/Applications/SimpleDB_2.10"
if [ -d "$SIMPLEDB_HOME" ] ; then
    export CLASSPATH=".:$SIMPLEDB_HOME/bin:$CLASSPATH"
fi

# Homebrew
if [ -d "/usr/local/sbin" ] ; then
    export PATH="/usr/local/sbin:$PATH"
fi

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# git - editor
export GIT_EDITOR=mousepad

# fix shader stuttering on AMD GPU
export RADV_PERFTEST=aco
