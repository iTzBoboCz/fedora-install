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
  sudo add-apt-repository ppa:linrunner/tlp
fi

# Color picker (Elementary OS)
# sudo api.github.com/repos/RonnyDo/ColorPicker/tarball

###
# Force update the whole system to the latest and greatest
###

sudo apt -qqy update && sudo apt -qqy upgrade

###
# Install base packages and applications
###

sudo apt \
-qqy install \
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
language-pack-gnome-cs `#System language (Czech)`
libreoffice-gnome `#Libreoffice integration for gnome` \
libreoffice `#office suite` \
meld `#Quick Diff Tool` \
nano \
nautilus-admin `#Open as administrator in nautilus` \
nautilus-gtkhash `#View file Hashes via nautilus` \
nautilus-nextcloud `#Also for the File Manager, shows you file status` \
neofetch \
nextcloud-desktop `#Nextcloud client` \
pulseeffects `#Tweak your Music!` \
snapd `#Snap daemon` \
sqlite-analyzer `#If you work with sqlite databases` \
sqlitebrowser \
synaptic `#GUI for APT` \
thunderbird `#Mail client` \
tlp `#Optimises battery usage` \
tlp-rdw \
ttf-mscorefonts-installer `#Microsoft's proprietary fonts` \
vlc `#Media player` \
zsh `#Syntax highlighting plugin for zsh` \
zsh-syntax-highlighting `#Syntax highlighting plugin for zsh`

. flatpak.sh

# https://gitlab.gnome.org/GabMus/giara

sudo snap install \
auto-cpufreq

# installs auto-cpufreq's daemon
sudo auto-cpufreq --install

#Install extensions to VSCode
#code --install-extension ms-vscode.atom-keybindings
# zhuangtongfa.Material-theme
# file-icons.file-icons
# ms-dotnettools.csharp
# jchannon.csharpextensions
# ms-vsliveshare.vsliveshare
# mohsen1.prettify-json

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
# Theming and GNOME Options
###

# run gnome.sh
. gnome.sh

###
# Other changes
###

# enable tlp
#sudo tlp start # enabled after reboot

# run HW Probe (https://linux-hardware.org)
# flatpak run org.linux_hardware.hw-probe

# set shell to zsh
if [ "${SHELL}" != $(which zsh) ]; then
  chsh -s $(which zsh)
fi

#Clone dotfiles
curl -LkSs https://github.com/iTzBoboCz/dotfiles/archive/master.zip -o dotfiles.zip \
&& unzip dotfiles.zip -d ~/ \
&& rm dotfiles.zip \
# && (shopt -s dotglob; mv ~/dotfiles-master/* ~/smazat) \
# && mv ~/dotfiles-master/* /smazat 2> /dev/null; mv ~/dotfiles-master/.* /smazat 2> /dev/null \
# && mv ~/dotfiles-master/ smazat/ \
&& cd ~

#The user needs to reboot to apply all changes.
echo "Gnome shell was restarted.\nNevertheless, it is recommended to restart your computer." && exit 0
