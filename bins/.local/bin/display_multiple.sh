#!/bin/sh

monitor=HDMI-0
laptop=eDP-1-1

xrandr --output $monitor --primary --mode 2560x1440 --pos 0x0 --rotate normal \
        --output $laptop --mode 1920x1080 --pos 2560x92 --rotate normal

# restart conky
pkill conky
start_conky_maia

# restore wallpaper
nitrogen --restore

# move 8th workspace to the laptop display
i3-msg "[workspace=\"8\"] move workspace to output $laptop"

# move all (except 7th and 8th) workspaces to the main display 
i3-msg "[workspace=\"1\"] move workspace to output $monitor"
i3-msg "[workspace=\"2\"] move workspace to output $monitor"
i3-msg "[workspace=\"3\"] move workspace to output $monitor"
i3-msg "[workspace=\"4\"] move workspace to output $monitor"
i3-msg "[workspace=\"5\"] move workspace to output $monitor"
i3-msg "[workspace=\"6\"] move workspace to output $monitor"
i3-msg "[workspace=\"7\"] move workspace to output $monitor"
i3-msg "[workspace=\"9\"] move workspace to output $monitor"
i3-msg "[workspace=\"10\"] move workspace to output $monitor"

# keyboard config
xset r rate 300 45
setxkbmap -option caps:escape
