#!/bin/sh
xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 1920x0 --rotate normal \
        --output eDP-1-1 --mode 1920x1080 --pos 0x180 --rotate normal

# restart conky
pkill conky
start_conky_maia

# move 7th and 8th workspace to the laptop display
i3-msg '[workspace="7"] move workspace to output eDP-1-1'
i3-msg '[workspace="8"] move workspace to output eDP-1-1'

# move all (except 7th and 8th) workspaces to the main display 
i3-msg '[workspace="1"] move workspace to output HDMI-0'
i3-msg '[workspace="2"] move workspace to output HDMI-0'
i3-msg '[workspace="3"] move workspace to output HDMI-0'
i3-msg '[workspace="4"] move workspace to output HDMI-0'
i3-msg '[workspace="5"] move workspace to output HDMI-0'
i3-msg '[workspace="6"] move workspace to output HDMI-0'
i3-msg '[workspace="9"] move workspace to output HDMI-0'
i3-msg '[workspace="10"] move workspace to output HDMI-0'
