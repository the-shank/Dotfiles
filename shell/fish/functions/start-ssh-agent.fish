function start-ssh-agent
    # somehow the `ssh-agent` that runs be default does not seem to work
    # specifically `ssh-add` is not able to connect to the running `ssh-agent`, even
    # thought `ps aux` tells that `ssh-agent` is running
    # as a temporary workaround, just ssh-agent manually
    eval (ssh-agent -c) > /dev/null
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
