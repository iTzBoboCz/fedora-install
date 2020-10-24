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
if [[ "{$ID_LIKE}" = "debian" ]]; then
  . distros/debian.sh
elif [[ "{$ID}" = "fedora" ]]; then
  . distros/fedora.sh
else
  printd "Your distribution of choice has not yet been manually confirmed to work with this script. Feel free to edit this according to your needs."
fi
