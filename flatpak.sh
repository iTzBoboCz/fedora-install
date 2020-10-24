#!/bin/bash

# add Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install apps
sudo flatpak install \
-y \
org.blender.Blender `#3D Software Powerhouse` \
com.visualstudio.code \
com.discordapp.Discord `#Communication client` \
com.github.tchx84.Flatseal `#A permissions manager for Flatpak` \
#flathub org.gabmus.giara `#Reddit native linux app` \
org.linux_hardware.hw-probe `#Detect drivers` \
com.github.marktext.marktext `#Simple yet powerful Markdown editor`

if [[ "{$STEAMFLAT}" = "true" ]]; then
  sudo flatpak install \
  -y \
  com.valvesoftware.Steam
fi
