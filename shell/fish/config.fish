if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# profile
source ~/.config/fish/profile.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /home/shank/Applications/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

