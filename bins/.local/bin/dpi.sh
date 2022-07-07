#! /bin/bash

# check that a dpi is provided
if [[ $# -ne 1 ]]; then
    echo "need dpi value"
    exit 1
fi

# update dpi
sed -i -e "s/^Xft\.dpi:.*/Xft\.dpi: \t$1/" ~/.Xresources

# merge the updated value
xrdb -merge ~/.Xresources

# restart i3 for the changes to come in effect
# note that some applications may need to be restarted for them to
# adapt to the new dpi value
i3-msg restart
