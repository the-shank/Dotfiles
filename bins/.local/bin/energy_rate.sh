#!/bin/bash

set -eu
set -o pipefail

upower -d | rg --ignore-case energy-rate | head -n1 | awk '{printf "%.2f%s\n", $2, $3}'
