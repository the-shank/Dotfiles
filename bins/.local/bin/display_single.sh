#!/bin/sh
# xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
# xrandr --output eDP-1-1 --primary
# xrandr --output eDP-1 --primary

display=$(xrandr --listmonitors | tail -n1 | awk '{print $4}')
xrandr --output $display --primary

# restart conky
pkill conky
start_conky_maia

# move all workspaces to the main display 
i3-msg "[workspace=\"1\"] move workspace to output $display"
i3-msg "[workspace=\"2\"] move workspace to output $display"
i3-msg "[workspace=\"3\"] move workspace to output $display"
i3-msg "[workspace=\"4\"] move workspace to output $display"
i3-msg "[workspace=\"5\"] move workspace to output $display"
i3-msg "[workspace=\"6\"] move workspace to output $display"
i3-msg "[workspace=\"7\"] move workspace to output $display"
i3-msg "[workspace=\"8\"] move workspace to output $display"
i3-msg "[workspace=\"9\"] move workspace to output $display"
i3-msg "[workspace=\"10\"] move workspace to output $display"
