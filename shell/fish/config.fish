if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# profile
source ~/.config/fish/sourced/profile.fish

# colored man output
source ~/.config/fish/sourced/colored_manpages.fish

# abbreviations
source ~/.config/fish/sourced/abbreviations.fish

# start tmux if running interactively
# if status --is-interactive
#     tmux 2> /dev/null; and exec true
# end

# dev: dct
test -e ~/.config/fish/sourced/dct.fish;
and source ~/.config/fish/sourced/dct.fish

