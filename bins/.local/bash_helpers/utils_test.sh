#!/bin/bash

curr_dir="$(realpath $(dirname "${BASH_SOURCE[0]}"))" 

SRC_FILE="utils.sh"

source "$curr_dir/$SRC_FILE"

ensure_cmp 1 "eq" 1 "Failed: ensure_cmp 1 \"eq\" 1"
ensure_cmp 1 "lt" 2 "Failed: ensure_cmp 1 \"lt\" 2"
ensure_cmp 1 "le" 1 "Failed: ensure_cmp 1 \"le\" 1"
ensure_cmp 2 "gt" 1 "Failed: ensure_cmp 2 \"gt\" 1"
ensure_cmp 1 "ge" 1 "Failed: ensure_cmp 1 \"ge\" 1"

ensure_equal 1 1 "Failed: enqure_equal 1 1"

ensure_one_arg_exact $# "Failed: ensure_one_arg_exact $#"

echo "[*] All tests passed"
