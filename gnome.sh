#!/bin/bash

#Gnome Shell Theming
# gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-${THEME}"
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_cursors'
# gsettings set org.gnome.desktop.interface icon-theme 'gnome'
# gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark-solid'

#Set SCP as Monospace (Code) Font
# gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro Semi-Bold 12'

#Better Font Smoothing
# gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

#Usability Improvements
gsettings set org.gnome.desktop.calendar show-weekdate true

#Install Extensions (https://github.com/brunelli/gnome-shell-extension-installer)
bash <(curl -s https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer) \
307 `#Dash to Dock` \
19 `#User Themes` \
3499 `#Application Volume Mixer`

if [[ "{$LAPTOP}" = "false" ]]; then
  bash <(curl -s https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer) \
  fi1625 `#Soft Brightness` \
fi

cd ~

#Dash to Dock tweaks
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock custom-background-color false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock icon-size-fixed false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock background-opacity 0.80000000000000004
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-trash true
# gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
# gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ get org.gnome.shell.extensions.dash-to-dock running-indicator-style

#This indexer is nice, but can be detrimental for laptop users battery life
if [[ "{$LAPTOP}" = "true" ]]; then
  gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery false
  gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery-first-time false
  gsettings set org.freedesktop.Tracker.Miner.Files throttle 15
fi

#Nautilus (File Manager) Usability
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
# gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.list-view use-tree-view false
gsettings set org.gnome.nautilus.preferences recursive-search 'always' # default is 'local-only'

#Gnome Night Light (Like flux/redshift)
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 19.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0

#Add gtk3-widget-factory as a desktop icon
cat > ~/.local/share/applications/gtk3-widget-factory.desktop << EOF
[Desktop Entry]
Name=Widget Factory
Comment=A showcase for GTK+ widgets, designed for testing themes.
Exec=gtk3-widget-factory
Icon=gtk3-widget-factory
Terminal=false
Type=Application
StartupNotify=true
Categories=GTK;
NoDisplay=false
EOF

#Change Wallpaper
# curl https://images.wallpaperscraft.com/image/house_forest_art_131857_2560x1600.jpg > ~/house_forest_art_131857_2560x1600.jpg
# gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/house_forest_art_131857_2560x1600.jpg"

dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'
