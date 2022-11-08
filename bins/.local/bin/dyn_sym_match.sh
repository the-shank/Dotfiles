#!/bin/bash

# this script find the number of undefined symbols for the first argument
# that can be resolved by the second argument

# check that we have two arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file> <library>"
    exit 1
fi

# check that both arguments are files
if [ ! -f $1 ]; then
    echo "$1 is not a file"
    exit 1
fi
if [ ! -f $2 ]; then
    echo "$2 is not a file"
    exit 1
fi

# get the list of undefined symbols for the first argument
undefined_symbols_fst=$(llvm-readelf --dyn-syms --demangle $1 | rg --ignore-case " und " | awk 'BEGIN {FS=" UND "};{print $2}' | sed -e 's/@.*//g' | sort)

# get he list of symbols defined in the second argument
defined_symbols_snd=$(nm -D --defined-only --demangle $2 | rg --ignore-case " T " | awk 'BEGIN {FS=" T "};{print $2}' | sed -e 's/@.*//g' | sort)

comm -12 <(echo "$undefined_symbols_fst") <(echo "$defined_symbols_snd")
