printf "This script can set up your freshly installed Pop!_OS.\nIt will overwrite some of your settings.\nContinue? [Y/N]: " && read CONTINUE

if [ "${CONTINUE}" != "Y" ]; then
  exit 1
fi

if [ $(id -u) = 0 ]; then
   printf "This script changes user's gsettings and should thus not be run as root!"
   exit 1
fi

###
# Remove unnecessary packages
###

sudo apt purge --auto-remove \
-y \


###
# Add other package sources
###

# SQLite
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser

# Github-desktop
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'

# Color picker (Elementary OS)
# sudo api.github.com/repos/RonnyDo/ColorPicker/tarball

# add Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# enable snaps
sudo apt install snapd -y

###
# Force update the whole system to the latest and greatest
###

sudo apt update && sudo apt upgrade -y

###
# Install base packages and applications
###

sudo apt install \
-y \
baobab `#Disk Usage Analyzer` \
breeze-cursor-theme `#A more comfortable Cursor Theme from KDE` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
file-roller `#GNOME Archive manager` \
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
nextcloud-desktop `#Nextcloud client` \
pulseeffects `#Tweak your Music!` \
sqlite-analyzer `#If you work with sqlite databases` \
sqlitebrowser \
synaptic `#GUI for APT` \
thunderbrid `#Mail client` \
ttf-mscorefonts-installer `#Microsoft's proprietary fonts` \
vlc `#Media player` \
zsh `#Syntax highlighting plugin for zsh` \
zsh-syntax-highlighting `#Syntax highlighting plugin for zsh`

sudo flatpak install \
-y \
org.blender.Blender `#3D Software Powerhouse` \
com.visualstudio.code \
com.discordapp.Discord `#Communication client` \
com.github.tchx84.Flatseal `#A permissions manager for Flatpak`

sudo snap install \
auto-cpufreq

# installs auto-cpufreq's daemon
sudo auto-cpufreq --install

###
# Theming and GNOME Options
###

#Set Extensions for gnome
gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'blyr@yozoon.dev.gmail.com']"

#Better Font Smoothing
# gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

#Usability Improvements
gsettings set org.gnome.desktop.calendar show-weekdate true

#Dash to Dock Theme
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.80000000000000000
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

#This indexer is nice, but can be detrimental for laptop users battery life
gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery false
gsettings set org.freedesktop.Tracker.Miner.Files index-on-battery-first-time false
gsettings set org.freedesktop.Tracker.Miner.Files throttle 15

#Nautilus (File Manager) Usability
# gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
# gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.list-view use-tree-view false

#Gnome Night Light (Like flux/redshift)
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 19.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
