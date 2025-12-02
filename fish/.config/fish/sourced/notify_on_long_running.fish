function notify_on_long_running --on-event fish_postexec
    set -l threshold 5000

    set -l ignored_cmds \
        # text editors
        nvim vim vi nano helix hx \
        # pagers & documentation
        man less \
        # remote & shells
        ssh telnet \
        # system monitors
        top htop btop nvtop iotop glances \
        # multiplexers
        tmux zellij screen \
        # file managers
        ranger yazi nnn lf mc \
        # interactive
        lazygit lazydocker python ipython fzf
    set -l cmd_clean (string replace -r '^sudo\s+' '' -- $argv[1])
    set -l cmd_name (string split -f1 " " -- $cmd_clean)
    if contains -- $cmd_name $ignored_cmds
        return
    end

    if test $CMD_DURATION -gt $threshold
        set -l status_msg Success
        if test $status -ne 0
            set status_msg Failed
        end

        notify-send "Task Finished ($status_msg)" "$argv" --icon utilities-terminal
    end
end
