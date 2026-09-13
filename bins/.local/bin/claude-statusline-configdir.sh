#!/usr/bin/env bash
# Prints c1/c2/c3/c4 (or the raw dir name as fallback) based on CLAUDE_CONFIG_DIR,
# for use as a Claude Code statusLine command.
cat >/dev/null # drain stdin JSON, unused

dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
base="$(basename "$dir")"

case "$base" in
    .claude1) echo "c1" ;;
    .claude2) echo "c2" ;;
    .claude3) echo "c3" ;;
    .claude4) echo "c4" ;;
    *) echo "$base" ;;
esac
