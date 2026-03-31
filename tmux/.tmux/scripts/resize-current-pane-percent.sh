#!/bin/sh

set -eu

action="${1:-}"
if [ "$action" != "grow" ] && [ "$action" != "shrink" ]; then
	printf "Usage: %s grow|shrink\n" "$0" >&2
	exit 2
fi

window_width=$(tmux display-message -p '#{window_width}')
window_height=$(tmux display-message -p '#{window_height}')

step_width=$((window_width * 5 / 100))
step_height=$((window_height * 5 / 100))

[ "$step_width" -lt 1 ] && step_width=1
[ "$step_height" -lt 1 ] && step_height=1

pane_at_left=$(tmux display-message -p '#{pane_at_left}')
pane_at_right=$(tmux display-message -p '#{pane_at_right}')
pane_at_bottom=$(tmux display-message -p '#{pane_at_bottom}')

if [ "$pane_at_left" -eq 1 ] && [ "$pane_at_right" -eq 1 ]; then
	if [ "$action" = "grow" ]; then
		if [ "$pane_at_bottom" -eq 0 ]; then
			tmux resize-pane -D "$step_height"
		else
			tmux resize-pane -U "$step_height"
		fi
	else
		if [ "$pane_at_bottom" -eq 0 ]; then
			tmux resize-pane -U "$step_height"
		else
			tmux resize-pane -D "$step_height"
		fi
	fi
else
	if [ "$action" = "grow" ]; then
		if [ "$pane_at_right" -eq 0 ]; then
			tmux resize-pane -R "$step_width"
		else
			tmux resize-pane -L "$step_width"
		fi
	else
		if [ "$pane_at_right" -eq 0 ]; then
			tmux resize-pane -L "$step_width"
		else
			tmux resize-pane -R "$step_width"
		fi
	fi
fi
