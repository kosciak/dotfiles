#!/usr/bin/env bash

# Move window to desktop's center
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Control><Shift>Home']"


# Set up Super+Num keyboard shortcut to switch between workspaces
for i in {1..9}
do
   gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
   # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "@as []"
done
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "@as []"


# Set up Super+Shift+Num keyboard shortcut to move windows between workspaces
for i in {1..9}
do
   gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"


# Set up Space Bar extension keybindings for "Back and forth" option to work properly
for i in {1..9}
do
   gsettings set org.gnome.shell.extensions.space-bar.shortcuts activate-$i-key "['<Super>$i']"
done
gsettings set org.gnome.shell.extensions.space-bar.shortcuts activate-10-key "['<Super>0']"


# Remove shortcuts to open / switch to predefined applications
for i in {1..9}
do
   gsettings set org.gnome.shell.keybindings switch-to-application-$i "@as []"
   gsettings set org.gnome.shell.keybindings open-new-window-application-$i "@as []"
done

