#! /bin/bash

# check that a dpi is provided
if [[ $# -ne 1 ]]; then
    echo "need dpi value"
    exit 1
fi

# update dpi in ~/.xsession
sed -i -e "s/dpi=[0-9]*/dpi=$1/" ~/.xsession

# execute ~/.xsession
sh ~/.xsession
