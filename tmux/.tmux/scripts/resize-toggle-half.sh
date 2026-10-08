#!/bin/sh
# ==============================================================================
# Toggle Current Pane Horizontal Half-Screen Resize
# ==============================================================================
#
# This script toggles the active pane width between 50% of the window width
# and its previous layout/dimension.
#
# State management:
# - Stored in pane-specific tmux options (@pane_half_toggled, @pane_half_saved_layout,
#   @pane_half_saved_width) so each pane maintains its own toggle state independently.
#
# Restoration strategy:
# 1. Primary: Restore the full window layout string (#{window_layout}). This
#    preserves exact proportions across all neighboring panes in multi-pane setups.
# 2. Fallback: If the window structure changed while toggled (e.g., a pane was
#    added or closed), select-layout fails; we fall back to resizing only the
#    active pane back to its saved column width.

set -eu

# Nothing to resize if the window has only one pane.
window_panes=$(tmux display-message -p '#{window_panes}')
if [ "$window_panes" -le 1 ]; then
	exit 0
fi

is_toggled=$(tmux display-message -p '#{@pane_half_toggled}')

if [ "$is_toggled" = "1" ]; then
	# Retrieve saved state before clearing pane options
	saved_layout=$(tmux display-message -p '#{@pane_half_saved_layout}')
	saved_width=$(tmux display-message -p '#{@pane_half_saved_width}')

	# Clear saved state
	tmux set-option -p -u @pane_half_toggled
	tmux set-option -p -u @pane_half_saved_layout
	tmux set-option -p -u @pane_half_saved_width

	# Attempt full window layout restore; fall back to pane width if layout changed
	if ! tmux select-layout "$saved_layout" 2>/dev/null; then
		if [ -n "$saved_width" ]; then
			tmux resize-pane -x "$saved_width"
		fi
	fi
else
	# Capture current state before resizing
	current_layout=$(tmux display-message -p '#{window_layout}')
	current_width=$(tmux display-message -p '#{pane_width}')

	tmux set-option -p @pane_half_toggled 1
	tmux set-option -p @pane_half_saved_layout "$current_layout"
	tmux set-option -p @pane_half_saved_width "$current_width"

	# Resize current pane to 50% width
	tmux resize-pane -x 50%
fi
