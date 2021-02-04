# Helper functions ============================================================

function _export --description "sets a variable"
    set --universal --export $argv[1] $argv[2]
end

function _add_to_path --description "add folder to path"
    contains $argv $PATH; or set PATH $argv $PATH
end

# Helper functions end ========================================================

# vi keybindings for fish
fish_vi_key_bindings

# $HOME/bin
test -d "$HOME/bin"; and _add_to_path "$HOME/bin"

# $HOME/.local/bin
test -d "$HOME/.local/bin"; and _add_to_path "$HOME/.local/bin"

# go
test -d "/usr/local/go/bin"; and _add_to_path "/usr/local/go/bin"
# go: gobin
test -d "$HOME/.local/gobin"; 
and _add_to_path "$HOME/.local/gobin";
and setenv GOBIN "$HOME/.local/gobin"

# go: gopath
test -d "$HOME/code/go";
and setenv GOPATH "$HOME/code/go"

# elixir: mix
test -d "$HOME/.mix"; and _add_to_path "$HOME/.mix"
test -d "$HOME/.mix/escripts"; and _add_to_path "$HOME/.mix/escripts"

# rust: cargo
test -d "$HOME/.cargo/bin"; and _add_to_path "$HOME/.cargo/bin"

# rust: enable backtrace
setenv RUST_BACKTRACE 1

# Android Studio
test -d "$HOME/Applications/android-studio/bin"; and _add_to_path "$HOME/Applications/android-studio/bin"

# ansible-galaxy
test -d "$HOME/code/utils/ansible-roles"; and _add_to_path "$HOME/code/utils/ansible-roles"

# java
test -d "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home" ; and _add_to_path "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home"
test -d "/usr/lib/jvm/default" ; and _export JDK_HOME "/usr/lib/jvm/default"

# homebrew fix
test -d "/usr/local/sbin"; and _add_to_path "/usr/local/sbin"

# ruby gems
test -d "$HOME/.gem/ruby/2.7.0/bin"; and _add_to_path "$HOME/.gem/ruby/2.7.0/bin"

# autojump
test -e "/usr/share/autojump/autojump.fish"; and source "/usr/share/autojump/autojump.fish"

# editor
if type --quiet nvim
    setenv GIT_EDITOR nvim
    setenv EDITOR nvim
else if type --quiet subl
    setenv GIT_EDITOR subl
    setenv EDITOR subl
end

# fix shader stuttering on AMD GPU
setenv RADV_PERFTEST "aco"

# bat (replacement for cat)
setenv BAT_THEME "base16"

# enable downgrading packages in Manjaro
setenv DOWNGRADE_FROM_ALA 1

# fzf
setenv FZF_DEFAULT_COMMAND 'rg --files-with-matches --hidden --follow --glob !.git/ ""'
setenv FZF_DEFAULT_OPTS '--layout=reverse'
setenv FZF_CTRL_T_COMMAND 'fd --hidden --ignore-case --follow --exclude .git/ ""'
setenv FZF_ALT_C_COMMAND 'fd --type d --hidden --ignore-case --follow --exclude .git/ ""'
setenv FZF_LEGACY_KEYBINDINGS 0

# map caps lock to escape
setxkbmap -option caps:escape

# llvm
test -d "/usr/local/opt/llvm/bin";
and _add_to_path "/usr/local/opt/llvm/bin";
and setenv LDFLAGS "/usr/local/opt/llvm/bin"
test -d "/usr/local/opt/llvm/include"; and setenv CPPFLAGS "/usr/local/opt/llvm/include"

# ssh-agent
# source: https://unix.stackexchange.com/a/132117
test -d $XDG_RUNTIME_DIR; and setenv SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"  
ssh-add -l >/dev/null 2>&1
if test $status -ge 2
    echo "starting ssh-agent"
    ssh-agent -a $SSH_AUTH_SOCK >/dev/null
end

# in case there is a .private file, source it
test -e "$HOME/.private"; and source $HOME/.private

# asdf
test -e "$HOME/.asdf/asdf.fish"; and source "$HOME/.asdf/asdf.fish"
