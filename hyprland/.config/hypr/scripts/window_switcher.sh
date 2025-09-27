#!/bin/bash
# Define the lengths for each column
ws_length=2
app_id_length=14
name_length=50

# Fetch the data from hyprctl and format it
formatted_output=$(hyprctl clients -j | jq -r --arg ws_length "$ws_length" --arg app_id_length "$app_id_length" --arg name_length "$name_length" '
  def lpad($len; $char):
    if (.|length) > $len then $char * ($len - (.|length)) + .[:($len-1)|tonumber] + "\u2026" else $char * ($len - (.|length)) + . end;
  def rpad($len; $char):
    if (.|length) > $len then .[:($len-1)|tonumber] + "\u2026" else . + $char * ($len - (.|length)) end;

  .[] |
  (if .focusHistoryID == 0 then "*" else " " end) as $asterisk |
  "\($asterisk)[\(.workspace.name | tostring | lpad($ws_length | tonumber; " "))]\((.class // "unknown") | lpad($app_id_length | tonumber; " ")): \(.title | rpad($name_length | tonumber; " ")) (\(.address))"
')

# Launch fuzzel with the formatted output
row=$(echo "$formatted_output" | fuzzel --dmenu --width=80 --lines=12)

# Get the window address from the selection and focus the window
if [ -n "$row" ]; then
  winid="${row##*(}"
  winid="${winid%%)*}"
  hyprctl dispatch focuswindow "address:$winid"
fi
