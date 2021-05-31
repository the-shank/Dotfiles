#!/usr/bin/env bash

while IFS="" read -r line
do
    echo "$line"
    stow --verbose --no-folding $line
done < stow_packages.txt
