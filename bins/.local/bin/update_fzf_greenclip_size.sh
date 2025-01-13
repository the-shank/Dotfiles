#!/bin/bash

set -eu
set -o pipefail

resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
width=$(echo $resolution | cut -d 'x' -f 1)
height=$(echo $resolution | cut -d 'x' -f 2)

window_width=$((width * 60 / 100))
window_height=$((height * 40 / 100))

# echo "$windows_width $window_height"

# update the i3config file
config_file="$HOME/dotfiles/i3/.config/i3/config"
sed -i '/^for_window \[class="floating"\]/c\for_window [class="floating"] floating enable, resize set '"$window_width $window_height"', move position center' "$config_file"

# realod i3 config
i3-msg reload
