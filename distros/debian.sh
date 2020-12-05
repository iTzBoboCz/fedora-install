#!/bin/bash

###
# Remove unnecessary packages
###

# sudo apt purge --auto-remove \
# -y \


###
# Add other package sources
###

# SQLite
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser

# Github-desktop
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'

if [ "${LAPTOP}" = true ]; then
  # TLP (Optimises battery usage)
  sudo add-apt-repository -y ppa:linrunner/tlp
fi

# Color picker (Elementary OS)
# sudo api.github.com/repos/RonnyDo/ColorPicker/tarball

###
# Force update the whole system to the latest and greatest
###

sudo apt -y "${QUIET_DOUBLE}" update && sudo apt -y "${QUIET_DOUBLE}" upgrade

###
# Install base packages and applications
###

sudo apt \
-y "${QUIET_DOUBLE}" install \
baobab `#Disk Usage Analyzer` \
breeze-cursor-theme `#A more comfortable Cursor Theme from KDE` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
file-roller `#GNOME Archive manager` \
gettext `#A must for compiling dash-to-dock (Makefile)` \
gimp \
git \
github-desktop \
gnome-tweak-tool \
gparted \
htop `#Cli process monitor` \
language-pack-gnome-cs `#System language (Czech)` \
libreoffice-gnome `#Libreoffice integration for gnome` \
libreoffice `#office suite` \
nano \
nautilus-admin `#Open as administrator in nautilus` \
nautilus-gtkhash `#View file Hashes via nautilus` \
nautilus-nextcloud `#Also for the File Manager, shows you file status` \
neofetch \
nextcloud-desktop `#Nextcloud client` \
snapd `#Snap daemon` \
sqlitebrowser \
synaptic `#GUI for APT` \
thunderbird `#Mail client` \
tlp `#Optimises battery usage` \
tlp-rdw \
ttf-mscorefonts-installer `#Microsoft's proprietary fonts` \
vlc `#Media player` \
zsh `#Syntax highlighting plugin for zsh` \
zsh-syntax-highlighting `#Syntax highlighting plugin for zsh`

# podpora jazyků
# hyphen-cs
# libreoffice-help-cs
# firefox-locale-cs
# fonts-noto-ui-core
# gimp-help-ja
# mozc-utils-gui
# gimp-help-ru
# hunspell-cs
# fonts-noto-core
# gimp-help-pt
# mythes-cs
# libreoffice-l10n-cs
# gimp-help-de
# gimp-help-fr
# gnome-user-docs-cs
# gimp-help-it
# gimp-help-es
# gnome-getting-started-docs-cs
# gimp-help-en

###
# Other changes
###

# enable tlp
#sudo tlp start # enabled after reboot
