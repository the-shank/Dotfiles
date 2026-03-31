#!/bin/sh

set -eu

usage() {
	printf "Usage: %s -l main-horizontal|main-vertical -p <1-100> [-t target-window]\n" "$0" >&2
}

layout_name=""
percentage=""
target=""

while getopts "l:p:t:" name; do
	case "$name" in
	l) layout_name="$OPTARG" ;;
	p) percentage="$OPTARG" ;;
	t) target="$OPTARG" ;;
	*)
		usage
		exit 2
		;;
	esac
done

if [ -z "$layout_name" ] || [ -z "$percentage" ]; then
	usage
	exit 2
fi

if [ "$layout_name" != "main-horizontal" ] && [ "$layout_name" != "main-vertical" ]; then
	printf "Layout name must be main-horizontal or main-vertical\n" >&2
	exit 1
fi

case "$percentage" in
'' | *[!0-9]*)
	printf "Percentage (-p) must be an integer\n" >&2
	exit 1
	;;
esac

if [ "$percentage" -lt 1 ] || [ "$percentage" -gt 100 ]; then
	printf "Percentage (-p) must be between 1 and 100\n" >&2
	exit 1
fi

if [ "$layout_name" = "main-vertical" ]; then
	window_width=$(tmux display-message -p '#{window_width}')
	main_pane_size=$((window_width * percentage / 100))
	main_size_option='main-pane-width'
else
	window_height=$(tmux display-message -p '#{window_height}')
	main_pane_size=$((window_height * percentage / 100))
	main_size_option='main-pane-height'
fi

[ "$main_pane_size" -lt 1 ] && main_pane_size=1

if [ -n "$target" ]; then
	tmux setw -t "$target" "$main_size_option" "$main_pane_size"
	tmux select-layout -t "$target" "$layout_name"
else
	tmux setw "$main_size_option" "$main_pane_size"
	tmux select-layout "$layout_name"
fi
