#!/usr/bin/env bash

# unlink existing links
stow --verbose --no-folding $1 2>&1 | \
    rg --ignore-case "existing target is not owned by stow" | \
    cut -d':' -f2 | \
    sed 's# #/home/shank/#g' | \
    xargs -t -n1 unlink

# stow !
stow --verbose --no-folding $1
