#!/usr/bin/env bash

while IFS="" read -r line
do
    echo ">>> stowing $line"
    stow --verbose --no-folding $line
done < stow_packages.txt
