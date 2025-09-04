# if on wayland, set special config for electron apps
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export ELECTRON_OZONE_PLATFORM_HINT=auto
fi
