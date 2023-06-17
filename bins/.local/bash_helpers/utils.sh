#!/bin/bash

# =======================================================================================
# Intended usage of this script is to include it in other bash scripts.
#
# Current list of util functions:
# 01. ensure_equal <arg1> <arg2>
# 02. ensure_one_arg <num>
# 03. ensure_one_arg_exact <num>
# =======================================================================================


# Args:
#   - <num1>
#   - "lt" | "le" | "eq" | "gt" | "ge"
#   - <num2>
#   - [<error_msg>]
ensure_cmp(){
  if [[ $# < 3 ]]; then
    echo "[!] ensure_cmp expects atleast 3 args"
    echo "[!] Usage: enquare_cmp <num1> \"lt\" <num2> [<error_msg>]"
    exit 1
  fi

  n1=$1
  op=$2
  n2=$3
  local error_msg=""
  if [[ $# == 3 ]]; then
    error_msg="[!] $3"
  fi

  case $op in
    "lt")
      if ! [[ $n1 < $n2 ]]; then
        echo "$error_msg"
        exit 1
      fi
      ;;

    "le")
      if ! [[ $n1 -le $n2 ]]; then
        echo "$error_msg"
        exit 1
      fi
      ;;

    "gt")
      if ! [[ $n1 > $n2 ]]; then
        echo "$error_msg"
        exit 1
      fi
      ;;

    "ge")
      if ! [[ $n1 -ge $n2 ]]; then
        echo "$error_msg"
        exit 1
      fi
      ;;

    "eq")
      if ! [[ $n1 == $n2 ]]; then
        echo "$error_msg"
        exit 1
      fi
      ;;

    *)
      echo "[!] invalid op: $op"
      exit 1
      ;;
      
  esac
}

# 01. ensure_equal
# Args:
#   - <num1>
#   - <num2>
#   - <error_msg>
# Returns: None
ensure_equal() {
  # atleast 2 args required
  ensure_cmp $# "ge" 2 "ensure_equal expects 2 args (nums to be compared), and optionally an error msg"

  local fst=$1
  local snd=$2
  local error_msg=""
  if [[ $# == 3 ]]; then
    error_msg="[!] $3"
  fi
  ensure_cmp $fst "eq" $snd $error_msg
}

# 02. ensure_one_arg
# Args: 
#   - <num_args>
# Returns: None
ensure_one_arg(){
  ensure_equal $# 1 "ensure_one_arg expects one arg, which is a number"

  local num_args=$1
  ensure_cmp $num_args "ge" 1 "expected 1 arg"
}


# 03. ensure_one_arg_exact
# Args: 
#   - <num_args>
# Returns: None
ensure_one_arg_exact(){
  ensure_equal $# 1 "ensure_one_arg_exact expects one arg, which is a number"

  local num_args=$1
  ensure_equal $num_args 1 "expected exactly 1 arg"
}
