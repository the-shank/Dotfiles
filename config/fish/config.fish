if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# pyenv
# status is-login; and pyenv init --path | source
# pyenv init - | source

# profile
source ~/.config/fish/sourced/profile.fish

# colored man output
source ~/.config/fish/sourced/colored_manpages.fish

# abbreviations
source ~/.config/fish/sourced/abbreviations.fish

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish" 

    # start tmux if running interactively
    # tmux 2> /dev/null; and exec true
end

# dev: dct
test -e ~/.config/fish/sourced/dct.fish;
and source ~/.config/fish/sourced/dct.fish

