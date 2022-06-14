#!/bin/bash

# NOTE:
# use autorandr for setting resolution/orientation
# this script is just to assign workspaces

display=$(xrandr --listmonitors | tail -n1 | awk '{print $4}')
xrandr --output "$display" --primary

# move all workspaces to the main display 
i3-msg "[workspace=\"1:I\"] move workspace to output $display"
i3-msg "[workspace=\"2:II\"] move workspace to output $display"
i3-msg "[workspace=\"3:III\"] move workspace to output $display"
i3-msg "[workspace=\"4:IV\"] move workspace to output $display"
i3-msg "[workspace=\"5:V\"] move workspace to output $display"
i3-msg "[workspace=\"6:VI\"] move workspace to output $display"
i3-msg "[workspace=\"7:VII\"] move workspace to output $display"
i3-msg "[workspace=\"8:VIII\"] move workspace to output $display"
i3-msg "[workspace=\"9:IX\"] move workspace to output $display"
i3-msg "[workspace=\"10:X\"] move workspace to output $display"

# keyboard config
xset r rate 300 45
setxkbmap -option caps:escape
