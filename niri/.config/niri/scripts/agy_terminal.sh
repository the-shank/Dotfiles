#!/usr/bin/env bash
set -euo pipefail

APP_ID="com.mitchellh.ghostty.agy"
HOST=$(uname -n)
DEVICE="${HOST#arco-}"
SESSION="agy-${DEVICE}"
START_DIR="${HOME}/dotfiles"

# If the dedicated agy Ghostty window is already open, focus it and exit.
TARGET_ID=$(
  niri msg --json windows |
    jq --raw-output --arg app "$APP_ID" '.[] | select(.app_id == $app) | .id' |
    head --lines=1
)

if [[ -n "$TARGET_ID" ]]; then
  niri msg action focus-window --id "$TARGET_ID"
  exit 0
fi

# Launch Ghostty and either attach to the existing tmux session (-A) or create
# a new session (-s) with an "agy" window (-n) in START_DIR (-c) running agy.
exec ghostty --class="$APP_ID" -e tmux new-session -A -s "$SESSION" -n "agy" -c "$START_DIR" fish --init-command=agy
