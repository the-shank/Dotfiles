#! /bin/bash

# reference:
# https://github.com/pop-os/shell/issues/142

# 10 workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# unbind keybindings for switching between applications
gsettings set org.gnome.shell.keybindings switch-to-application-1  []
gsettings set org.gnome.shell.keybindings switch-to-application-2  []
gsettings set org.gnome.shell.keybindings switch-to-application-3  []
gsettings set org.gnome.shell.keybindings switch-to-application-4  []
gsettings set org.gnome.shell.keybindings switch-to-application-5  []
gsettings set org.gnome.shell.keybindings switch-to-application-6  []
gsettings set org.gnome.shell.keybindings switch-to-application-7  []
gsettings set org.gnome.shell.keybindings switch-to-application-8  []
gsettings set org.gnome.shell.keybindings switch-to-application-9  []

# rebind them to switch between workspaces on Alt+<N>
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Alt>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Alt>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Alt>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Alt>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Alt>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Alt>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Alt>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Alt>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Alt>0']"

# move window to workspaces on Super+Alt+<N>
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Shift>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Shift>9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"
