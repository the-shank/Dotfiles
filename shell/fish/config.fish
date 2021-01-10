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

# LOCAL TO THIS MACHINE (MX)
# somehow the `ssh-agent` that runs be default does not seem to work
# specifically `ssh-add` is not able to connect to the running `ssh-agent`, even
# thought `ps aux` tells that `ssh-agent` is running
# as a temporary workaround, just start another ssh-agent
if test -z (pgrep ssh-agent)
    eval (ssh-agent -c) > /dev/null
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
