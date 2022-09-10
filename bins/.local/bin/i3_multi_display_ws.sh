#!/bin/bash

# NOTE:
# use autorandr for setting resolution/orientation
# this script is just to assign workspaces

monitor=
laptop=

monitor=$(xrandr --listmonitors | rg --ignore-case hdmi | awk '{print $NF}')
if [[ -z "$monitor" ]]; then
    monitor=$(xrandr --listmonitors | rg --ignore-case displayport | awk '{print $NF}')
fi
echo "identified monitor: $monitor"

laptop=$(xrandr --listmonitors | rg --ignore-case eDP | awk '{print $NF}')
echo "identified laptop: $laptop"

# if either monitor or laptop is not set, exit
if [[ -z "$monitor" ]] || [[ -z "$laptop" ]]
then
    exit 1
fi

# workspaces on laptop display
# i3-msg "[workspace=\"8:VIII\"] move workspace to output $laptop"
# i3-msg "[workspace=\"10:X\"] move workspace to output $laptop"

# workspaces on main monitor display
i3-msg "[workspace=\"1:I\"] move workspace to output $monitor"
i3-msg "[workspace=\"2:II\"] move workspace to output $monitor"
i3-msg "[workspace=\"3:III\"] move workspace to output $monitor"
i3-msg "[workspace=\"4:IV\"] move workspace to output $monitor"
i3-msg "[workspace=\"5:V\"] move workspace to output $monitor"
i3-msg "[workspace=\"6:VI\"] move workspace to output $monitor"
i3-msg "[workspace=\"7:VII\"] move workspace to output $monitor"
i3-msg "[workspace=\"8:VIII\"] move workspace to output $monitor"
i3-msg "[workspace=\"9:IX\"] move workspace to output $monitor"
i3-msg "[workspace=\"10:X\"] move workspace to output $monitor"

# keyboard config
xset r rate 300 45
setxkbmap -option caps:escape
