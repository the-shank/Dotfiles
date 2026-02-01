export QT_QPA_PLATFORMTHEME="qt6ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/firefox

# if on wayland, set special config for electron apps
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export ELECTRON_OZONE_PLATFORM_HINT=auto
fi
