#!/bin/bash

set -e

# check that we have 2 arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

# check that the files exist
if [ ! -f $1 ]; then
    echo "File $1 does not exist"
    exit 1
fi
if [ ! -f $2 ]; then
    echo "File $2 does not exist"
    exit 1
fi

ldd_file1=$(ldd $1 | rg "=>" | awk '{print $1}' | sort)
ldd_file2=$(ldd $2 | rg "=>" | awk '{print $1}' | sort)
diff --side-by-side --suppress-common-lines <(echo "$ldd_file1") <(echo "$ldd_file2")
