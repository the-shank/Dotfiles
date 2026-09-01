#!/bin/sh
# ==============================================================================
# 3-Column Pane Layout for Tmux (e.g., 30% - 40% - 30%)
# ==============================================================================
#
# This script arranges or resizes 3 columns in the current or targeted tmux window
# into a 30% - 40% - 30% horizontal ratio (customizable).
#
# Behavior:
# - If the window is structured as 3 columns (e.g., 3 single panes, or 4+ panes
#   where some columns have vertically stacked panes), it resizes the column
#   widths without altering any vertical splits/heights within those columns.
# - If there are exactly 3 panes not yet arranged into columns, it first applies
#   `even-horizontal` before sizing.

set -eu

usage() {
	printf "Usage: %s [-l left_percent] [-c center_percent] [-r right_percent] [-t target-window]\n" "$0" >&2
	printf "Defaults: left=30, center=40, right=30\n" >&2
}

left_pct=30
center_pct=40
right_pct=30
target=""

while getopts "l:c:r:t:h" opt; do
	case "$opt" in
	l) left_pct="$OPTARG" ;;
	c) center_pct="$OPTARG" ;;
	r) right_pct="$OPTARG" ;;
	t) target="$OPTARG" ;;
	h)
		usage
		exit 0
		;;
	*)
		usage
		exit 2
		;;
	esac
done

# Validate percentage inputs are integers
for val in "$left_pct" "$center_pct" "$right_pct"; do
	case "$val" in
	'' | *[!0-9]*)
		printf "Error: Percentage values must be positive integers\n" >&2
		exit 1
		;;
	esac
done

# Check that percentages sum to 100
total=$((left_pct + center_pct + right_pct))
if [ "$total" -ne 100 ]; then
	printf "Error: Percentages must sum to 100 (got %d)\n" "$total" >&2
	exit 1
fi

# Build target prefix for tmux commands
target_args=""
target_pane_prefix=""
if [ -n "$target" ]; then
	target_args="-t $target"
	target_pane_prefix="${target}."
fi

# Count total panes and distinct column X-coordinates (pane_left)
# shellcheck disable=SC2086
pane_count=$(tmux display-message $target_args -p '#{window_panes}')
# shellcheck disable=SC2086
col_count=$(tmux list-panes $target_args -F '#{pane_left}' | sort -u | wc -l)

if [ "$col_count" -eq 3 ]; then
	# Window already has 3 columns (e.g. 3 panes, or 4 panes with stacked sub-panes).
	# Resize outer columns horizontally to preserve any vertical sub-splits.
	tmux resize-pane -t "${target_pane_prefix}{top-left}" -x "${left_pct}%"
	tmux resize-pane -t "${target_pane_prefix}{bottom-right}" -x "${right_pct}%"
elif [ "$pane_count" -eq 3 ]; then
	# Window has 3 panes but they are not yet in 3 columns (e.g. stacked rows).
	# shellcheck disable=SC2086
	tmux select-layout $target_args even-horizontal
	tmux resize-pane -t "${target_pane_prefix}{top-left}" -x "${left_pct}%"
	tmux resize-pane -t "${target_pane_prefix}{bottom-right}" -x "${right_pct}%"
else
	# shellcheck disable=SC2086
	tmux display-message $target_args "Layout requires 3 columns (found $col_count columns across $pane_count panes)"
fi
