#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login


##############################################################################

# source -> https://vincent.bernat.ch/en/blog/2018-4k-hidpi-dual-screen-linux#hidpi-support-on-linux-with-x11

# Target DPI
dpi=126

# For applications supporting XSettings, `Xft/DPI' sets font scaling
# (and sometimes interface scaling), `Gdk/WindowScalingFactor' sets
# interface scaling with GTK 3, and `Gdk/UnscaledDPI' undo font scaling
# for GTK 3 applications.
# > ~/.xsettingsd cat <<EOF
> ~/.xsettingsd cat <<EOF
Xft/DPI $(( $dpi*1024 ))
Gdk/WindowScalingFactor $(( $dpi/96 ))
Gdk/UnscaledDPI $(( $dpi*1024/($dpi/96) ))
EOF
pkill -HUP xsettingsd || xsettingsd &

# For Qt applications.
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR_ROUNDING_POLICY=PassThrough

# For miscellaneous applications.
echo Xft.dpi: $dpi | xrdb -merge

##############################################################################
