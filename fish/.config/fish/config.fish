# pyenv
# status is-interactive; and pyenv init --path | source
# pyenv init - | source

# profile
source ~/.config/fish/sourced/profile.fish

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

# prompt
starship init fish | source
