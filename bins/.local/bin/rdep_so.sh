#! /bin/bash

# check that we have 2 arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <so_filename> <path_to_search>"
    exit 1
fi

# set variables for the arguments
so_filename=$1
path_to_search=$2

# check that path_to_search exists
if [ ! -e $path_to_search ]; then
    echo "Error: $path_to_search does not exist"
    exit 1
fi

fd . $path_to_search | \
    xargs -n1 -I{} -P$(nproc) bash -c "patchelf --print-needed {} 2>/dev/null | rg $so_filename >/dev/null; if [ \$? -eq 0 ]; then echo \"{}\"; fi" 2>/dev/null
