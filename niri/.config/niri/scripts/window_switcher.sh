#!/bin/bash

# 1. Get all windows in JSON format
WINDOWS=$(niri msg -j windows)

# 2. Parse JSON to format: "WorkspaceID | WindowTitle | AppID" and pipe to Fuzzel
# We store the Window ID as hidden data or just map it back later.
# Here we use a trick to pass the ID as the first field but hide it or strip it after selection.
TARGET=$(echo "$WINDOWS" | jq -r '.[] | "\(.id) \t [\(.workspace_id // "Scratch")] \(.title) - \(.app_id)"' |
  fuzzel -d --prompt="Switch to: " --width 80 --lines 15)

# 3. If the user selected something (didn't press Esc)
if [ -n "$TARGET" ]; then
  # Extract the ID (first field before the tab)
  ID=$(echo "$TARGET" | awk '{print $1}')

  # Tell Niri to focus that window
  niri msg action focus-window --id "$ID"
fi
