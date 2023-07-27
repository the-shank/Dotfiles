function setup --description "sets up the environment variables and all"
    # Helper functions ============================================================

    function _export --description "sets a variable"
        set --erase $argv[1]
        set --universal --export $argv[1] $argv[2]
    end

    # function _prepend_to_path --description "prepend folder to path"
    #     # contains $argv $PATH; or set PATH $argv $PATH
    #     contains $argv $fish_user_paths; or set -Up fish_user_paths $argv
    # end

    # function _append_to_path --description "append folder to path"
    #     # contains $argv $PATH; or set PATH $argv $PATH
    #     contains $argv $fish_user_paths; or set -Ua fish_user_paths $argv
    # end

    # Helper functions end ========================================================

    # go: gopath
    test -d "$HOME/code/go";
        and _export GOPATH "$HOME/code/go"

    # rust: enable backtrace
    _export RUST_BACKTRACE 1

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

    # fzf (not applicable to patrickf1/fzf.fish)
    # _export FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob '!.git'"
    # _export FZF_DEFAULT_OPTS '--layout=reverse'
    # _export FZF_CTRL_T_COMMAND 'fd --hidden --ignore-case --follow --exclude .git/ --exclude .local/share/Steam/ --exclude .cache/ ""'
    # _export FZF_ALT_C_COMMAND 'fd --type d --hidden --ignore-case --follow --exclude .git/ --exclude .local/share/Steam/ --exclude .cache/ ""'
    # _export FZF_LEGACY_KEYBINDINGS 0

    # done (notification for long running terminal tasks)
    _export __done_notify_sound 1

    # C and C++ compilers (clang/clang++)
    _export CC /usr/bin/clang
    _export CXX /usr/bin/clang++

    # AFL++ - dont complain about cpu frequency scaling
    _export AFL_SKIP_CPUFREQ 1

    # dark theme for qt applications
    _export QT_QPA_PLATFORMTHEME qt5ct
    _export QT_STYLE_OVERRIDE kvantum
    _export QT_SCALE_FACTOR 1.1

    # remove fish_greeting
    set --export --universal fish_greeting
end
