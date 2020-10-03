#!/bin/bash

# Default variables
STEAMFLAT=false
LAPTOP=false
NVIDIA=false
HELP_MSG="Optional arguments are:\n  --help | -h: Help page\n  --steam: Installs steam (flatpak version to avoid lib misaligment issues for games)\n  --laptop: Enables powersaving features\n  --nvidia: Installs proprietary drivers."

# arg implicitly iterates over $@ (the array of positional parameters) and is equivalent to the explicit for arg in $@
for arg
do
  case "${arg}" in
    --help | -h) printf "${HELP_MSG}" && exit 1;;
    --steam) STEAMFLAT=true;;
    --laptop) LAPTOP=true;;
    --nvidia) NVIDIA=true;;
    *)
      echo "Unknown argument"
      exit 1
      ;;
   esac
done

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

# add Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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

sudo flatpak install \
-y \
org.blender.Blender `#3D Software Powerhouse` \
com.visualstudio.code \
com.discordapp.Discord `#Communication client` \
com.github.tchx84.Flatseal `#A permissions manager for Flatpak` \
com.github.marktext.marktext `#Simple yet powerful Markdown editor`

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

#Gnome Shell Theming
# gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-${THEME}"
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_cursors'
# gsettings set org.gnome.desktop.interface icon-theme 'gnome'
# gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark-solid'

#Better Font Smoothing
# gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

#Usability Improvements
gsettings set org.gnome.desktop.calendar show-weekdate true

#Install Dash-to-Dock
cd ~/.local/share/gnome-shell/extensions

sudo curl -o dash-to-dock@micxgx.gmail.com.zip https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v68.shell-extension.zip \
&& gnome-extensions install dash-to-dock@micxgx.gmail.com.zip \
&& sudo rm dash-to-dock@micxgx.gmail.com.zip

sudo curl -o user-theme@gnome-shell-extensions.gcampax.github.com.zip https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v40.shell-extension.zip \
&& gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com.zip \
&& sudo rm user-theme@gnome-shell-extensions.gcampax.github.com.zip

cd ~

#Dash to Dock settings
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock custom-background-color false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock background-opacity 0.80000000000000000
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-trash false

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
curl https://images.wallpaperscraft.com/image/house_forest_art_131857_2560x1600.jpg > ~/house_forest_art_131857_2560x1600.jpg
gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/house_forest_art_131857_2560x1600.jpg"

dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'

###
# Other changes
###

# enable tlp
#sudo tlp start # enabled after reboot

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
