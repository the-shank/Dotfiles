function notify_on_long_running --on-event fish_postexec
    set -l last_status $status
    set -l threshold 5000

    # Ignored bins
    set -l ignored_bins \
        # text editors
        nvim vim vi nano helix hx \
        # pagers & documentation
        man less bat \
        # remote & shells
        ssh telnet \
        # system monitors
        top htop btop nvtop iotop glances \
        # multiplexers
        tmux zellij screen \
        # file managers
        ranger y yazi nnn lf mc \
        # interactive
        lazygit lazydocker python ipython fzf git rga-fzf ldconfig
    set -l cmd_clean (string replace -r '^sudo\s+' '' -- $argv[1])
    set -l cmd_name (string split -f1 " " -- $cmd_clean)
    if contains -- $cmd_name $ignored_bins
        return
    end

    # ignored command prefixes
    set -l ignored_prefixes \
        "docker container attach" \
        "docker container start" \
        "docker attach" \
        "git rebase"
    for prefix in $ignored_prefixes
        if string match -q -- "$prefix*" $cmd_clean
            return
        end
    end

    if test $CMD_DURATION -gt $threshold
        set -l status_msg Success
        if test $last_status -ne 0
            set status_msg Failed
        end

        if type -q notify-send
            notify-send "Task Finished ($status_msg)" "$argv" --icon utilities-terminal
        else
            send_slack_notification.sh "$status_msg | $argv"
        end
    end
end
