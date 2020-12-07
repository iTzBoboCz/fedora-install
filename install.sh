#!/bin/bash

# Default variables
STEAMFLAT=false
LAPTOP=false
NVIDIA=false
QUIET=""
QUIET_DOUBLE=""
HELP_MSG="Optional arguments are:\n  --help | -h: Help page\n  --steam: Installs steam (flatpak version to avoid lib misaligment issues for games)\n  --laptop: Enables powersaving features\n  --nvidia: Installs proprietary drivers."

# arg implicitly iterates over $@ (the array of positional parameters) and is equivalent to the explicit for arg in $@
for arg
do
  case "${arg}" in
    --help | -h) printf "${HELP_MSG}" && exit 1;;
    --steam) STEAMFLAT=true;;
    --laptop) LAPTOP=true;;
    --nvidia) NVIDIA=true;;
    --quiet | -q) QUIET="-q" && QUIET_DOUBLE="-qq";;
    *)
      echo "Unknown argument"
      exit 1
      ;;
   esac
done

printf "This script can set up your freshly installed system.\nIt will overwrite some of your settings.\nContinue? [Y/N]: " && read CONTINUE

if [ "${CONTINUE}" != "Y" ]; then
  printf "Operation terminated."
  exit 1
fi

if [ $(id -u) = 0 ]; then
   printf "This script changes user's gsettings and should thus not be run as root!"
   exit 1
fi

# load os info
source /etc/os-release

# Pop!_OS, Ubuntu, Mint,..
if [[ "${ID_LIKE}" = *"debian"* ]]; then
  . distros/debian.sh
elif [[ "${ID}" = "fedora" ]]; then
  . distros/fedora.sh
else
  printf "Your distribution of choice has not yet been manually confirmed to work with this script. Feel free to edit this according to your needs."
fi

# installs flatpak apps
. flatpak.sh

# installs snap
#. snap.sh

# Pop!_OS outputs Unity
if [[ "${XDG_CURRENT_DESKTOP}" == "GNOME" || "${XDG_CURRENT_DESKTOP}" == "Unity" ]]; then
  . gnome.sh
fi

# install Oh My Zsh
if ! command -v zsh &> /dev/null; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#Clone dotfiles
curl -LkSs https://github.com/iTzBoboCz/dotfiles/archive/master.zip -o dotfiles.zip \
&& unzip dotfiles.zip -d ~/ \
&& rm dotfiles.zip \
&& cd ~

#The user needs to reboot to apply all changes.
echo "Gnome shell was restarted.\nNevertheless, it is recommended to restart your computer." && exit 0
