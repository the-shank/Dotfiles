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

function check_file(){
    # check that the function is called with 1 argument
    if [ $# -ne 1 ]; then
        echo "Error: check_file() called with $# arguments"
        exit 1
    fi

    # set variable for the argument
    file_to_check=$1
    
    # use absolute path to file
    file_to_check=$(realpath $file_to_check)

    # if path_to_search is a file, then just check that file
    contains=$(llvm-readelf --needed-libs $file_to_check 2>/dev/null | rg "$so_filename")
    if [ -n "$contains" ]; then
        echo "$file_to_check"
    fi
}

# if path_to_search is a file, then just check that file
if [ -f $path_to_search ]; then
    check_file $path_to_search
    exit 0
fi


function check_directory(){
    # check that the function is called with 1 argument
    if [ $# -ne 1 ]; then
        echo "Error: check_directory() called with $# arguments"
        exit 1
    fi

    # set variable for the argument
    directory_to_check=$1

    # use absolute path to directory
    directory_to_check=$(realpath $directory_to_check)

    # check that directory_to_check is a directory
    if [ ! -d $directory_to_check ]; then
        echo "Error: $directory_to_check is not a directory"
        exit 1
    fi

    # check all files in directory_to_check
    for file in $directory_to_check/*; do
        if [ -f $file ]; then
            check_file $file
        elif [ -d $file ]; then
            check_directory $file
        fi
    done
}

# if we reached this point, then path_to_search is a directory
check_directory $path_to_search

# # for each binary, run the command
# for bin in $bins
# do
#     # filter out the binaries
#     binpath="/usr/bin/$bin"
#     isbinary=$(file $binpath | grep -q "ELF 64-bit")
#     if [ $? -eq 0 ]
#     then
#         # check the needed libs for each binary
#         contains=$(llvm-readelf --needed-libs $binpath | rg "$1")
#         if [ -n "$contains" ]; then
#             echo "$bin needs $1"
#         fi
#     fi
# done
