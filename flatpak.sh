#!/bin/bash

# add Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak remote-add --if-not-exists --user freedesktop-sdk https://cache.sdk.freedesktop.org/freedesktop-sdk.flatpakrepo

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
#org.cvfosammmm.Setzer `#LaTeX editor`

# Basic setup of VSCode
vscodeextensions=(\
ms-vscode.atom-keybindings `#Atom editor keybindings; Feel free to remove this if you aren't used to these.` \
rafaelmardojai.vscode-gnome-theme `#Color theme to match gnome's adwaita` \
zhuangtongfa.Material-theme `#Material theme` \
file-icons.file-icons `#File icons` \
ms-dotnettools.csharp \
jchannon.csharpextensions \
ms-vsliveshare.vsliveshare `#Live code cooperation` \
mohsen1.prettify-json `#JSON Prettifier` \
)

for e in ${vscodeextensions[@]}; do
  flatpak run com.visualstudio.code --install-extension $e
done

# Steam games (32bit) have issues with the too new 32bit compat libs in fedora
# Flatpak is the better option here
if [[ "{$STEAMFLAT}" = "true" ]]; then
  sudo flatpak install \
  -y \
  com.valvesoftware.Steam

  # Mesa-ACO makes steam render WAY better under amd cards.
  # flatpak install --user freedesktop-sdk \
  #   org.freedesktop.Platform.GL.mesa-aco//19.08 \
  #   org.freedesktop.Platform.GL32.mesa-aco//19.08
  #
  # flatpak update --user

  #To run it with mesa-aco:
  #FLATPAK_GL_DRIVERS=mesa-aco flatpak run com.valvesoftware.Steam
  # Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam
fi
