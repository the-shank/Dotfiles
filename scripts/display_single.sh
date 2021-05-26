#!/bin/sh
xrandr --output HDMI-0 --off \
        --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal

# restart conky
pkill conky
start_conky_maia

# move all (except 7th and 8th) workspaces to the main display 
i3-msg '[workspace="1"] move workspace to output eDP-1-1'
i3-msg '[workspace="2"] move workspace to output eDP-1-1'
i3-msg '[workspace="3"] move workspace to output eDP-1-1'
i3-msg '[workspace="4"] move workspace to output eDP-1-1'
i3-msg '[workspace="5"] move workspace to output eDP-1-1'
i3-msg '[workspace="6"] move workspace to output eDP-1-1'
i3-msg '[workspace="7"] move workspace to output eDP-1-1'
i3-msg '[workspace="8"] move workspace to output eDP-1-1'
i3-msg '[workspace="9"] move workspace to output eDP-1-1'
i3-msg '[workspace="10"] move workspace to output eDP-1-1'
