#!/bin/bash

# Usage: ./focus_window.sh "app-id-or-title"

TARGET_ID=$(niri msg --json windows | jq -r ".[] | select((.app_id | contains(\"$1\")) or (.title | contains(\"$1\"))) | .id" | head -n 1)

if [ -n "$TARGET_ID" ]; then
  # Focus the window by its ID
  niri msg action focus-window --id "$TARGET_ID"
# else
#     # Optional: Launch the app if it's not running
#     # (Remove this block if you only want to focus existing windows)
#     if [ "$1" == "firefox" ]; then
#         niri msg action spawn firefox
#     elif [ "$1" == "alacritty" ]; then
#         niri msg action spawn alacritty
#     fi
fi
