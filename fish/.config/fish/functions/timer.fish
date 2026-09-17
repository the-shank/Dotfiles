function timer --description "timer timer in HH:MM:SS format"
    if test (count $argv) -eq 0
        echo "Usage: timer <duration>"
        echo ""
        echo "Examples:"
        echo "  timer 30          # 30 seconds"
        echo "  timer 5m          # 5 minutes"
        echo "  timer 1h30m       # 1 hour 30 minutes"
        echo "  timer 1h30m45s    # 1h 30m 45s"
        echo "  timer 01:30:00    # HH:MM:SS"
        echo "  timer 5:00        # MM:SS"
        return 1
    end

    set -l input $argv[1]
    set -l total 0

    if string match -qr '^[0-9]+:[0-9]+:[0-9]+$' -- $input
        set -l p (string split ':' -- $input)
        set total (math "$p[1] * 3600 + $p[2] * 60 + $p[3]")
    else if string match -qr '^[0-9]+:[0-9]+$' -- $input
        set -l p (string split ':' -- $input)
        set total (math "$p[1] * 60 + $p[2]")
    else if string match -qr '^[0-9]+$' -- $input
        set total $input
    else if string match -qr '^([0-9]+h)?([0-9]+m)?([0-9]+s)?$' -- $input; and test -n "$input"
        set -l hm (string match -r '([0-9]+)h' -- $input)
        set -l mm (string match -r '([0-9]+)m' -- $input)
        set -l sm (string match -r '([0-9]+)s' -- $input)
        set -l h 0
        set -l m 0
        set -l s 0
        test (count $hm) -ge 2; and set h $hm[2]
        test (count $mm) -ge 2; and set m $mm[2]
        test (count $sm) -ge 2; and set s $sm[2]
        set total (math "$h * 3600 + $m * 60 + $s")
    else
        echo "Invalid duration: $input"
        return 1
    end

    if test $total -le 0
        echo "Duration must be positive"
        return 1
    end

    # Hide the cursor and make sure it's restored on Ctrl+C
    printf '\e[?25l'
    function __timer_cleanup --on-signal INT
        printf '\e[?25h\n'
        functions -e __timer_cleanup
    end

    # Use an absolute end time so the timer doesn't drift
    set -l end_time (math (date +%s) + $total)
    set -l remaining $total

    while test $remaining -gt 0
        set -l h (math -s0 "$remaining / 3600")
        set -l m (math -s0 "($remaining % 3600) / 60")
        set -l s (math -s0 "$remaining % 60")
        printf '\r%02d:%02d:%02d' $h $m $s
        sleep 1
        set remaining (math $end_time - (date +%s))
    end

    printf '\r00:00:00\n'
    printf '\e[?25h'
    functions -q __timer_cleanup; and functions -e __timer_cleanup
    printf '\a' # terminal bell when done
end
