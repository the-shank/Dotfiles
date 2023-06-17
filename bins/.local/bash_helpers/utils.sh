#!/bin/bash

# =======================================================================================
# Intended usage of this script is to include it in other bash scripts.
#
# Current list of util functions:
# 01. ensure_one_arg
# 02. ensure_one_arg_exact
# =======================================================================================


# 01. ensure_one_arg
# Args: None
# Returns: None
ensure_one_arg(){
  if [[ $# < 1 ]]; then
    echo "[!] less than 1 arg provided"
    exit 1
  fi
}


# 02. ensure_one_arg_exact
# Args: None
# Returns: None
ensure_one_arg_exact(){
  if [[ $# != 1 ]]; then
    echo "[!] exactly 1 arg should be provided however $# args were provided"
    exit 1
  fi
}
