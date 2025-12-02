function notify_on_long_running --on-event fish_postexec
    set -l threshold 5000

    if test $CMD_DURATION -gt $threshold
        set -l status_msg Success
        if test $status -ne 0
            set status_msg Failed
        end

        notify-send "Task Finished ($status_msg)" "$argv" --icon utilities-terminal
    end
end
