function setup --description "sets up the environment variables and all"
    # Helper functions ============================================================

    function _export --description "sets a variable"
        set --erase $argv[1]
        set --universal --export $argv[1] $argv[2]
    end

    function _prepend_to_path --description "prepend folder to path"
        # contains $argv $PATH; or set PATH $argv $PATH
        contains $argv $fish_user_paths; or set -Up fish_user_paths $argv
    end

    function _append_to_path --description "append folder to path"
        # contains $argv $PATH; or set PATH $argv $PATH
        contains $argv $fish_user_paths; or set -Ua fish_user_paths $argv
    end

    # Helper functions end ========================================================

    # vi keybindings for fish
    fish_vi_key_bindings

    # $HOME/bin
    test -d "$HOME/bin"; and _append_to_path "$HOME/bin"

    # $HOME/.local/bin
    test -d "$HOME/.local/bin"; and _append_to_path "$HOME/.local/bin"

    # go
    test -d "/usr/local/go/bin"; and _append_to_path "/usr/local/go/bin"
    # go: gobin
    test -d "$HOME/.local/gobin"; 
        and _append_to_path "$HOME/.local/gobin";
        and _export GOBIN "$HOME/.local/gobin"

    # go: gopath
    test -d "$HOME/code/go";
        and _export GOPATH "$HOME/code/go"

    # elixir: mix
    test -d "$HOME/.mix"; and _append_to_path "$HOME/.mix"
    test -d "$HOME/.mix/escripts"; and _append_to_path "$HOME/.mix/escripts"

    # rust: cargo
    test -d "$HOME/.cargo/bin"; and _append_to_path "$HOME/.cargo/bin"

    # rust: enable backtrace
    _export RUST_BACKTRACE 1

    # Android Studio
    test -d "$HOME/Applications/android-studio/bin"; and _append_to_path "$HOME/Applications/android-studio/bin"

    # ansible-galaxy
    test -d "$HOME/code/utils/ansible-roles"; and _append_to_path "$HOME/code/utils/ansible-roles"

    # java
    test -d "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home" ; and _append_to_path "/Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home"
    test -d "/usr/lib/jvm/default" ; and _export JDK_HOME "/usr/lib/jvm/default"

    # homebrew fix
    test -d "/usr/local/sbin"; and _append_to_path "/usr/local/sbin"

    # ruby gems
    test -d "$HOME/.gem/ruby/2.7.0/bin"; and _append_to_path "$HOME/.gem/ruby/2.7.0/bin"

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
    _export BAT_THEME "base16"

    # enable downgrading packages in Manjaro
    _export DOWNGRADE_FROM_ALA 1

    # fzf
    _export FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob '!.git'"
    _export FZF_DEFAULT_OPTS '--layout=reverse'
    _export FZF_CTRL_T_COMMAND 'fd --hidden --ignore-case --follow --exclude .git/ --exclude .local/share/Steam/ --exclude .cache/ ""'
    _export FZF_ALT_C_COMMAND 'fd --type d --hidden --ignore-case --follow --exclude .git/ --exclude .local/share/Steam/ --exclude .cache/ ""'
    _export FZF_LEGACY_KEYBINDINGS 0

    # map caps lock to escape
    setxkbmap -option caps:escape

    # llvm
    test -d "/usr/local/opt/llvm/bin";
        and _append_to_path "/usr/local/opt/llvm/bin";
        and _export LDFLAGS "/usr/local/opt/llvm/bin"
    test -d "/usr/local/opt/llvm/include"; and _export CPPFLAGS "/usr/local/opt/llvm/include"

    # pycharm
    test -e "$HOME/Applications/pycharm-community"; and _append_to_path "$HOME/Applications/pycharm-community/bin"

    # gcloud
    test -e "$HOME/Applications/google-cloud-sdk";
    and _append_to_path "$HOME/Applications/google-cloud-sdk/bin"

    # done (notification for long running terminal tasks)
    _export __done_notify_sound 1

    # rim (rm-improved)
    _export GRAVEYARD $HOME/.local/share/Trash/files

    # C and C++ compilers (clang/clang++)
    _export CC /usr/bin/clang
    _export CXX /usr/bin/clang++

    # purs3mango specific - neovim
    test -e "$HOME/applications/neovim";
        and _append_to_path "$HOME/applications/neovim/bin"

    # purs3mango specific - nodejs
    test -e "$HOME/applications/node";
        and _append_to_path "$HOME/applications/node/bin"

    # purs3lab: bear
    test -d "$HOME/Applications/bear/bin";
        and _append_to_path "$HOME/Applications/bear/bin"

    # llvm-12
    test -d "$HOME/Applications/llvm-12/bin";
        and _prepend_to_path "$HOME/Applications/llvm-12/bin"
end
