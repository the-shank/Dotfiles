# Helper functions ============================================================

function _export --description "sets a variable"
    set --universal --export $argv[1] $argv[2]
end

function _add_to_path --description "add folder to path"
    _export fish_user_paths $fish_user_paths $argv
end

# Helper functions end ========================================================

# $HOME/bin
test -d "$HOME/bin"; and _add_to_path "$HOME/bin"

# $HOME/.local/bin
test -d "$HOME/.local/bin"; and _add_to_path "$HOME/.local/bin"

# go: gobin
test -d "$HOME/.local/gobin"; 
and _add_to_path "$HOME/.local/gobin";
and _export GOBIN "$HOME/.local/gobin"

# go: gopath
test -d "$HOME/Code/go"; and _export GOPATH "$HOME/Code/go"

# mix (elixir)
test -d "$HOME/.mix"; and _add_to_path "$HOME/.mix"
test -d "$HOME/.mix/escripts"; and _add_to_path "$HOME/.mix/escripts"

# rust: cargo
test -d "$HOME/.cargo/bin"; and _add_to_path "$HOME/.cargo/bin"

# rust: enable backtrace
_export RUST_BACKTRACE full

# set PATH so it includes user's Android Studio bin if it exists
test -d "$HOME/Applications/android-studio/bin"; and _add_to_path "$HOME/Applications/android-studio/bin"

# ansible-galaxy
test -d "$HOME/Code/UTILS/ANSIBLE-ROLES"; and _add_to_path "$HOME/Code/UTILS/ANSIBLE-ROLES"

# Java
test -d "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home" ; and _add_to_path "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home"

# Homebrew
test -d "/usr/local/sbin"; and _add_to_path "/usr/local/sbin"

# autojump
test -e "/usr/share/autojump/autojump.fish"; and source "/usr/share/autojump/autojump.fish"

# editor
if type --quiet nvim
    _export GIT_EDITOR nvim
    _export EDITOR nvim
else if type --quiet subl
    _export GIT_EDITOR subl
    _export EDITOR subl
end

# fix shader stuttering on AMD GPU
_export RADV_PERFTEST "aco"

# bat (replacement for cat)
_export BAT_THEME "gruvbox"

# enable downgrading packages in Manjaro
_export DOWNGRADE_FROM_ALA 1

# fzf
_export FZF_DEFAULT_COMMAND 'rg -l ""'

# map caps lock to escape
setxkbmap -option caps:escape

# llvm
test -d "/usr/local/opt/llvm/bin";
and _add_to_path "/usr/local/opt/llvm/bin";
and _export LDFLAGS "/usr/local/opt/llvm/bin"
test -d "/usr/local/opt/llvm/include"; and _export CPPFLAGS "/usr/local/opt/llvm/include"

# ssh-agent
test -d $XDG_RUNTIME_DIR; and _export SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"  

# in case there is a .private file, source it
test -e "$HOME/.private"; and source $HOME/.private