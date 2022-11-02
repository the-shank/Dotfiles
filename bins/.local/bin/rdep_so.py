#!/usr/bin/env python3

import sys
import os
import logging
import subprocess

logging.basicConfig(level=logging.DEBUG)


def uses_so(full_path, so_filename) -> bool:
    # get the ldd output
    try:
        output = subprocess.check_output(
            ["ldd", full_path], stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        return False

        # check if the output contains the shared object
    return so_filename in str(output)


def main() -> None:
    # ensure that we have 2 args
    if len(sys.argv) != 3:
        print("Usage: rdep_so.py <so_filename> <path_to_search>")
        sys.exit(1)

    # get the args
    so_filename = sys.argv[1]
    path_to_search = sys.argv[2]

    # get the absolute path
    path_to_search = os.path.abspath(path_to_search)
    # logging.info("Searching for '%s' in '%s'", so_filename, path_to_search)

    # queue of paths to search
    paths_to_search = [path_to_search]

    # get the list of files
    while paths_to_search:
        # get the next path to search
        path_to_search = paths_to_search.pop(0)
        # logging.info("Searching %s", path_to_search)

        # if the item is a file,
        if os.path.isfile(path_to_search):
            # check if it uses the shared object via ldd output
            if uses_so(path_to_search, so_filename):
                print(path_to_search)
            continue

        # iterate over the items in the path
        for item in os.listdir(path_to_search):
            # logging.info("> Checking %s", item)

            # get the full path to the item
            full_path = os.path.join(path_to_search, item)

            # if the item is a directory, add it to the queue
            if os.path.isdir(full_path):
                paths_to_search.append(full_path)

            # if the item is a file,
            elif os.path.isfile(full_path):
                # check if it uses the shared object via ldd output
                if uses_so(full_path, so_filename):
                    print(full_path)


if __name__ == "__main__":
    main()
