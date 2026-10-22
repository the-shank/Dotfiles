#!/usr/bin/env bash
# ==============================================================================
# Antigravity CLI (agy) Tmux Session Switcher
# ==============================================================================
#
# Opens an fzf picker over all local Antigravity CLI conversations, annotating
# any conversations currently open in a live tmux pane, adapting its colors
# automatically to the current desktop color-scheme (light / dark), and
# switching the preview pane between horizontal (right) and vertical (bottom)
# based on popup dimensions.
#
# Keybindings inside fzf:
# - Ctrl+n / Ctrl+p : Move down / up in the conversation list.
# - Enter  : Jump to the existing tmux pane if open, or open a new tmux window
#            in the conversation's project directory and resume it.
# - Ctrl+s : Jump to the existing tmux pane if open, or split the current tmux
#            window horizontally and resume the conversation.
# - Alt+n  : Start a brand-new agy session in a new tmux window using the
#            selected conversation's project directory (or caller pane path).
# - Ctrl+/ : Manually cycle preview layout (right -> bottom -> hidden).
# - Ctrl+u / Ctrl+d : Scroll the conversation transcript preview up/down.

set -euo pipefail

AGY_DIR="${HOME}/.gemini/antigravity-cli"
DB_PATH="${AGY_DIR}/conversation_summaries.db"
BRAIN_DIR="${AGY_DIR}/brain"

caller_pane=""
caller_path=""
mode="interactive"
preview_cid=""
preview_workspace=""
preview_pane=""

# ==============================================================================
# Argument Parsing
# ==============================================================================

while [[ $# -gt 0 ]]; do
	case "$1" in
	--caller-pane)
		caller_pane="${2:-}"
		shift 2
		;;
	--caller-path)
		caller_path="${2:-}"
		shift 2
		;;
	--list-only)
		mode="list"
		shift
		;;
	--preview)
		mode="preview"
		preview_cid="${2:-}"
		preview_workspace="${3:-}"
		preview_pane="${4:-}"
		shift 4
		;;
	*)
		shift
		;;
	esac
done

# Query tmux directly for the active pane ID and working directory if not passed
if [[ "$mode" != "preview" ]]; then
	if [[ -z "$caller_pane" && -n "${TMUX:-}" ]]; then
		caller_pane=$(tmux display-message -p '#{pane_id}')
	fi
	if [[ -z "$caller_path" || "$caller_path" == *'#{'* ]]; then
		if [[ -n "${TMUX:-}" ]]; then
			caller_path=$(tmux display-message -p '#{pane_current_path}')
		else
			caller_path="$PWD"
		fi
	fi
fi

# ==============================================================================
# Theme Detection (Light vs Dark Mode)
# ==============================================================================
#
# Check the current desktop color-scheme set by `tolight` / `todark` via gsettings
# (falling back to nvim's options.lua if gsettings is unavailable).
# In `gruvbox-material-dark-hard`, ANSI bright0 (color 8 / \033[90m) is #32302f,
# which is nearly identical to the #1d2021 background. We use TrueColor
# (\033[38;2;R;G;Bm) and explicit fzf `--color` palettes to guarantee legible
# contrast in both light and dark themes.

detect_theme_mode() {
	if [[ -n "${AGY_THEME_MODE:-}" ]]; then
		printf '%s' "$AGY_THEME_MODE"
		return
	fi
	local cs=""
	if command -v gsettings >/dev/null 2>&1; then
		cs=$(gsettings get org.gnome.desktop.interface color-scheme)
	fi
	if [[ "$cs" == *"prefer-dark"* ]]; then
		printf 'dark'
	elif [[ "$cs" == *"default"* || "$cs" == *"prefer-light"* ]]; then
		printf 'light'
	elif [[ -f "$HOME/dotfiles/neovim/.config/nvim-lazyvim/lua/config/options.lua" ]] &&
		grep -q 'background = "light"' "$HOME/dotfiles/neovim/.config/nvim-lazyvim/lua/config/options.lua"; then
		printf 'light'
	else
		printf 'dark'
	fi
}

AGY_THEME_MODE=$(detect_theme_mode)
export AGY_THEME_MODE

if [[ "$AGY_THEME_MODE" == "light" ]]; then
	# Light palette (matches tokyonight-day-vscode / gruvbox-light)
	C_RESET=$'\033[0m'
	C_BOLD=$'\033[1m'
	C_MUTED=$'\033[38;2;108;112;134m'   # #6c7086 (readable slate gray)
	C_PATH=$'\033[38;2;0;108;134m'      # #006c86 (teal/cyan)
	C_TITLE=$'\033[1;38;2;52;59;89m'    # #343b59 (bold dark navy)
	C_TEXT=$'\033[38;2;52;59;89m'       # #343b59 (dark navy)
	C_GREEN=$'\033[1;38;2;72;94;48m'    # #485e30 (forest green)
	C_YELLOW=$'\033[1;38;2;143;94;21m'  # #8f5e15 (warm amber)
	C_BLUE=$'\033[1;38;2;41;89;170m'    # #2959aa (royal blue)

	FZF_THEME_COLORS="light,bg:#e6e7ed,fg:#343b59,bg+:#d6d8df,fg+:#1f2335:bold,hl:#8c4351:bold:underline,hl+:#8c4351:bold:underline,info:#6c7086,prompt:#2959aa,pointer:#8c4351,marker:#485e30,spinner:#8f5e15,header:#485e30,border:#9ca0b0,separator:#9ca0b0,preview-bg:#e6e7ed,preview-fg:#343b59"
else
	# Dark palette (matches gruvbox-material-dark-hard)
	C_RESET=$'\033[0m'
	C_BOLD=$'\033[1m'
	C_MUTED=$'\033[38;2;146;131;116m'   # #928374 (gruvbox medium gray, visible on #1d2021)
	C_PATH=$'\033[38;2;137;180;130m'    # #89b482 (gruvbox aqua)
	C_TITLE=$'\033[1;38;2;212;190;152m' # #d4be98 (bold gruvbox fg)
	C_TEXT=$'\033[38;2;212;190;152m'    # #d4be98 (gruvbox fg)
	C_GREEN=$'\033[1;38;2;169;182;101m' # #a9b665 (gruvbox green)
	C_YELLOW=$'\033[1;38;2;216;166;87m' # #d8a657 (gruvbox yellow)
	C_BLUE=$'\033[1;38;2;125;174;163m'  # #7daea3 (gruvbox blue)

	FZF_THEME_COLORS="dark,bg:#1d2021,fg:#d4be98,bg+:#32302f,fg+:#ebdbb2:bold,hl:#d8a657:bold:underline,hl+:#ea6962:bold:underline,info:#928374,prompt:#7daea3,pointer:#ea6962,marker:#a9b665,spinner:#d8a657,header:#a9b665,border:#504945,separator:#504945,preview-bg:#1d2021,preview-fg:#d4be98"
fi

# ==============================================================================
# Preview Rendering Mode (invoked by fzf --preview)
# ==============================================================================

render_preview() {
	local cid="$1"
	local ws="$2"
	local pane="$3"

	if [[ "$cid" == "__NEW__" ]]; then
		printf '%s+ Start a New Antigravity (agy) Conversation%s\n' "$C_GREEN" "$C_RESET"
		printf '%s────────────────────────────────────────────────────────────%s\n' "$C_MUTED" "$C_RESET"
		printf '%sWorkspace:%s %s\n\n' "$C_BOLD" "$C_RESET" "$ws"
		printf 'Press %sEnter%s or %sAlt+n%s to open a new tmux window in\n' "$C_YELLOW" "$C_RESET" "$C_YELLOW" "$C_RESET"
		printf '%s%s%s and start a fresh agy session.\n\n' "$C_PATH" "$ws" "$C_RESET"
		printf 'Tip: Highlighting any existing conversation below and pressing\n'
		printf '%sAlt+n%s will start a fresh agy session in that project directory.\n' "$C_YELLOW" "$C_RESET"
		return 0
	fi

	# Query metadata from conversation_summaries.db using non-whitespace separator
	local meta=""
	if [[ -f "$DB_PATH" ]]; then
		meta=$(sqlite3 -cmd ".timeout 2000" -separator $'\x1f' "$DB_PATH" \
			"SELECT
				title,
				CASE WHEN last_modified_time LIKE '0001-%' OR last_modified_time = ''
					THEN 'active (unstarted)'
					ELSE strftime('%Y-%m-%d %H:%M:%S', last_modified_time, 'localtime')
				END,
				step_count,
				status,
				replace(replace(preview, char(10), ' '), char(9), ' ')
			 FROM conversation_summaries
			 WHERE conversation_id = '$cid' LIMIT 1;")
	fi

	local title="" mod_time="" steps="" status="" preview_text=""
	if [[ -n "$meta" ]]; then
		IFS=$'\x1f' read -r title mod_time steps status preview_text <<<"$meta"
	fi
	[[ -z "$title" ]] && title="(New / Untitled Session)"

	printf '%s%s%s\n' "$C_BLUE" "$title" "$C_RESET"
	printf '%s────────────────────────────────────────────────────────────%s\n' "$C_MUTED" "$C_RESET"
	printf '%sConversation:%s %s\n' "$C_BOLD" "$C_RESET" "$cid"
	printf '%sWorkspace:%s    %s\n' "$C_BOLD" "$C_RESET" "$ws"
	if [[ -n "$pane" ]]; then
		local pane_loc=""
		pane_loc=$(tmux display-message -p -t "$pane" '#{session_name}:#{window_index}.#{pane_index} (#{window_name})')
		printf '%sTmux Status:%s  %sOpen in pane %s -> %s%s\n' "$C_BOLD" "$C_RESET" "$C_GREEN" "$pane" "$pane_loc" "$C_RESET"
	else
		printf '%sTmux Status:%s  %sClosed (Enter: new window, Ctrl+s: split pane)%s\n' "$C_BOLD" "$C_RESET" "$C_MUTED" "$C_RESET"
	fi
	if [[ -n "$mod_time" ]]; then
		printf '%sLast Active:%s  %s  %s(Steps: %s, Status: %s)%s\n' "$C_BOLD" "$C_RESET" "$mod_time" "$C_MUTED" "${steps:-0}" "${status:-IDLE}" "$C_RESET"
	fi
	printf '%s────────────────────────────────────────────────────────────%s\n\n' "$C_MUTED" "$C_RESET"

	local transcript="${BRAIN_DIR}/${cid}/.system_generated/logs/transcript.jsonl"
	if [[ -f "$transcript" ]]; then
		jq -r --arg c_user "$C_YELLOW" --arg c_agy "$C_BLUE" --arg c_rst "$C_RESET" '
			select(.type == "USER_INPUT" or (.type == "PLANNER_RESPONSE" and (.content // "" | length > 0)))
			| if .type == "USER_INPUT" then
				$c_user + "❯ User:" + $c_rst + "\n" + (
					(.content // "")
					| sub("(?s)^.*<USER_REQUEST>\\n?"; "")
					| sub("(?s)\\n?</USER_REQUEST>.*$"; "")
					| sub("(?s)\\n?<ADDITIONAL_METADATA>.*</ADDITIONAL_METADATA>"; "")
					| sub("(?s)\\n?<USER_SETTINGS_CHANGE>.*</USER_SETTINGS_CHANGE>"; "")
				) + "\n"
			  else
				$c_agy + "◆ Antigravity:" + $c_rst + "\n" + (.content // "") + "\n"
			  end
		' "$transcript" | tail -n 80
	elif [[ -n "$preview_text" ]]; then
		printf '%sPreview:%s\n%s\n' "$C_YELLOW" "$C_RESET" "$preview_text"
	else
		printf '%s(No transcript messages recorded yet)%s\n' "$C_MUTED" "$C_RESET"
	fi
}

if [[ "$mode" == "preview" ]]; then
	render_preview "$preview_cid" "$preview_workspace" "$preview_pane"
	exit 0
fi

# ==============================================================================
# Active Process & Tmux Pane Discovery
# ==============================================================================

declare -A active_pane=()
declare -A active_cwd=()
declare -A pane_label=()

if [[ -n "${TMUX:-}" ]]; then
	while IFS='|' read -r p_id p_loc; do
		[[ -n "$p_id" ]] && pane_label["$p_id"]="$p_loc"
	done < <(tmux list-panes -a -F '#{pane_id}|#{window_index}.#{pane_index}')
fi

# Scan running agy CLI processes and inspect their open presence/*.lock file descriptors
while IFS= read -r pid; do
	[[ -n "$pid" && -r "/proc/$pid/environ" ]] || continue
	p_id=$(tr '\0' '\n' <"/proc/$pid/environ" | sed -n 's/^TMUX_PANE=//p' | head -n 1)
	[[ -z "$p_id" ]] && continue
	[[ -n "${pane_label[$p_id]:-}" ]] || continue

	for fd in "/proc/$pid/fd/"*; do
		[[ -L "$fd" ]] || continue
		# A file descriptor can close mid-scan; ignore disappeared links
		target=$(readlink "$fd" || true)
		if [[ "$target" == *"/.gemini/antigravity-cli/presence/"*".lock" ]]; then
			cid="${target##*/}"
			cid="${cid%.lock}"
			active_pane["$cid"]="$p_id"
			if [[ -L "/proc/$pid/cwd" ]]; then
				active_cwd["$cid"]=$(readlink -f "/proc/$pid/cwd" || printf '%s' "$HOME")
			else
				active_cwd["$cid"]="$HOME"
			fi
		fi
	done
done < <(pgrep -u "$USER" -x agy || true)

# ==============================================================================
# Build Searchable Conversation List
# ==============================================================================

shorten_path() {
	local p="$1"
	local out="$p"
	if [[ "$p" == "$HOME" ]]; then
		out="~"
	elif [[ "$p" == "$HOME/"* ]]; then
		# shellcheck disable=SC2088
		out="~/${p#"$HOME/"}"
	fi
	# Keep project paths compact (<= 24 chars) so columns align without pushing titles off-screen
	if ((${#out} > 24)); then
		out="…/${out: -22}"
	fi
	printf '%s' "$out"
}

generate_rows() {
	local short_caller
	short_caller=$(shorten_path "$caller_path")

	# First row: quick option to launch a fresh agy conversation in the caller's project
	printf '__NEW__\t%s\t\t%s+ %s  %s%-11s%s  %s%-24s%s  %sStart a new agy conversation in %s%s\n' \
		"$caller_path" "$C_GREEN" "$C_RESET" "$C_MUTED" "now" "$C_RESET" "$C_PATH" "$short_caller" "$C_RESET" "$C_GREEN" "$short_caller" "$C_RESET"

	[[ -f "$DB_PATH" ]] || return 0

	local open_rows=()
	local closed_rows=()
	declare -A seen_cid=()

	# Read CLI conversations ordered by most recently modified using ASCII Unit Separator (\x1f)
	# so empty columns are never collapsed by Bash's whitespace IFS splitting.
	while IFS=$'\x1f' read -r cid title ws_json mod_time steps status busy preview_snip; do
		[[ -z "$cid" ]] && continue
		seen_cid["$cid"]=1

		local pane="${active_pane[$cid]:-}"
		# Skip abandoned 0-step empty sessions unless currently open in a live tmux pane
		if [[ -z "$pane" && "$steps" == "0" && -z "$title" ]]; then
			continue
		fi

		# Extract first workspace URI from JSON array (e.g. ["file:///home/shank/dotfiles"])
		local ws_path=""
		if [[ "$ws_json" == *'file://'* ]]; then
			ws_path="${ws_json#*file://}"
			ws_path="${ws_path%%\"*}"
		fi
		if [[ -z "$ws_path" ]]; then
			ws_path="${active_cwd[$cid]:-$HOME}"
		fi

		local short_ws
		short_ws=$(shorten_path "$ws_path")

		if [[ -z "$title" ]]; then
			title="(New session in ${short_ws})"
		fi

		# Include preview keywords if they add search terms beyond the title
		local extra_search=""
		if [[ -n "$preview_snip" && "$preview_snip" != "$title" ]]; then
			extra_search="  ${C_MUTED}· ${preview_snip}${C_RESET}"
		fi

		local badge="" row=""
		if [[ -n "$pane" ]]; then
			if [[ "$busy" == "1" || "$status" == *"RUNNING"* ]]; then
				badge="⏳"
			else
				badge="🟢"
			fi
			printf -v row '%s\t%s\t%s\t%s  %s%-11s%s  %s%-24s%s  %s%s%s%s' \
				"$cid" "$ws_path" "$pane" "$badge" "$C_MUTED" "$mod_time" "$C_RESET" "$C_PATH" "$short_ws" "$C_RESET" "$C_TITLE" "$title" "$C_RESET" "$extra_search"
			open_rows+=("$row")
		else
			badge="⚪"
			printf -v row '%s\t%s\t\t%s  %s%-11s%s  %s%-24s%s  %s%s%s%s' \
				"$cid" "$ws_path" "$badge" "$C_MUTED" "$mod_time" "$C_RESET" "$C_PATH" "$short_ws" "$C_RESET" "$C_TEXT" "$title" "$C_RESET" "$extra_search"
			closed_rows+=("$row")
		fi
	done < <(sqlite3 -cmd ".timeout 2000" -separator $'\x1f' "$DB_PATH" "
		SELECT
			conversation_id,
			replace(replace(title, char(10), ' '), char(9), ' '),
			workspace_uris,
			CASE WHEN last_modified_time LIKE '0001-%' OR last_modified_time = ''
				THEN 'active'
				ELSE strftime('%m-%d %H:%M', last_modified_time, 'localtime')
			END,
			step_count,
			status,
			not_fully_idle,
			substr(replace(replace(preview, char(10), ' '), char(9), ' '), 1, 70)
		FROM conversation_summaries
		WHERE app_data_dir = 'antigravity-cli'
		  AND nesting_depth = 0
		  AND killed = 0
		ORDER BY last_modified_time DESC;
	")

	# Also include any brand-new active pane whose lock exists before a DB row is written
	for cid in "${!active_pane[@]}"; do
		if [[ -z "${seen_cid[$cid]:-}" ]]; then
			local pane="${active_pane[$cid]}"
			local ws_path="${active_cwd[$cid]:-$HOME}"
			local short_ws
			short_ws=$(shorten_path "$ws_path")
			local row=""
			printf -v row '%s\t%s\t%s\t🟢  %s%-11s%s  %s%-24s%s  %s(New session in %s)%s' \
				"$cid" "$ws_path" "$pane" "$C_MUTED" "active" "$C_RESET" "$C_PATH" "$short_ws" "$C_RESET" "$C_TITLE" "$short_ws" "$C_RESET"
			open_rows+=("$row")
		fi
	done

	for row in "${open_rows[@]}"; do
		printf '%s\n' "$row"
	done
	for row in "${closed_rows[@]}"; do
		printf '%s\n' "$row"
	done
}

if [[ "$mode" == "list" ]]; then
	generate_rows
	exit 0
fi

# ==============================================================================
# Responsive Preview Window Layout (Horizontal vs Vertical)
# ==============================================================================
#
# Determine whether the popup / terminal window is wider (landscape) or narrower
# (portrait / half-screen) by comparing character columns against rows * 2.2
# (since terminal cells are roughly twice as tall as they are wide).
# Additionally, fzf's `<140(bottom,50%,wrap)` dynamically flips to vertical
# stacking if the window is resized below 140 columns while open.

cols=$(tput cols)
lines=$(tput lines)
if ((cols >= 140 && cols >= lines * 22 / 10)); then
	preview_layout="right,48%,wrap,<140(bottom,50%,wrap)"
else
	preview_layout="bottom,50%,wrap"
fi

# ==============================================================================
# Interactive FZF Selection & Tmux Action Dispatch
# ==============================================================================

script_self=$(readlink -f "$0")

set +e
fzf_out=$(
	generate_rows | fzf \
		--ansi \
		--color="$FZF_THEME_COLORS" \
		--delimiter=$'\t' \
		--with-nth=4.. \
		--expect=alt-n,ctrl-alt-n,ctrl-s \
		--header=$'Enter: jump/new-win │ Ctrl-s: split │ Alt-n: new chat │ Ctrl-/: layout │ Ctrl-u/d: scroll' \
		--preview="bash '$script_self' --preview {1} {2} {3}" \
		--preview-window="$preview_layout" \
		--bind='ctrl-n:down' \
		--bind='ctrl-p:up' \
		--bind='ctrl-/:change-preview-window(bottom,50%,wrap|right,48%,wrap|hidden)' \
		--bind='ctrl-u:preview-half-page-up' \
		--bind='ctrl-d:preview-half-page-down' \
		--bind='ctrl-t:preview-top' \
		--bind='ctrl-b:preview-bottom' \
		--no-sort \
		--layout=reverse
)
fzf_rc=$?
set -e

[[ $fzf_rc -ne 0 || -z "$fzf_out" ]] && exit 0

key=$(head -n 1 <<<"$fzf_out")
selection=$(sed -n '2p' <<<"$fzf_out")

[[ -z "$selection" ]] && exit 0

IFS=$'\t' read -r sel_cid sel_ws sel_pane _ <<<"$selection"

# Ensure workspace directory exists; fall back to HOME if deleted
if [[ -z "$sel_ws" || ! -d "$sel_ws" ]]; then
	sel_ws="$HOME"
fi

# Case 1: User pressed Alt+n (or Ctrl+Alt+n) or selected the "+ " row -> start a fresh agy conversation
if [[ "$key" == "alt-n" || "$key" == "ctrl-alt-n" || "$sel_cid" == "__NEW__" ]]; then
	tmux new-window -n "agy" -c "$sel_ws" "exec agy"
	exit 0
fi

# Case 2: Selected conversation is already open in a tmux pane -> switch to that pane
if [[ -n "$sel_pane" ]] && tmux list-panes -a -F '#{pane_id}' | grep -Fxq "$sel_pane"; then
	target_session=$(tmux display-message -p -t "$sel_pane" '#{session_name}')
	target_window=$(tmux display-message -p -t "$sel_pane" '#{window_id}')
	tmux switch-client -t "$target_session"
	tmux select-window -t "$target_window"
	tmux select-pane -t "$sel_pane"
	exit 0
fi

# Case 3: Selected conversation is closed -> open in split pane (Ctrl+s) or new window (Enter)
if [[ "$key" == "ctrl-s" ]]; then
	if [[ -n "$caller_pane" ]]; then
		tmux split-window -h -t "$caller_pane" -c "$sel_ws" "exec agy --conversation '$sel_cid'"
	else
		tmux split-window -h -c "$sel_ws" "exec agy --conversation '$sel_cid'"
	fi
else
	tmux new-window -n "agy" -c "$sel_ws" "exec agy --conversation '$sel_cid'"
fi
