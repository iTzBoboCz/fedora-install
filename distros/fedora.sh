#!/bin/bash

###
# Optionally clean all dnf temporary files
###

sudo dnf clean all

###
# RpmFusion Free Repo
# This is holding only open source, vetted applications - fedora just cant legally distribute them themselves thanks to
# Software patents
###

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

###
# RpmFusion NonFree Repo
# This includes Nvidia Drivers and more
###

if [ ! -z "$NONFREE" ]; then
	sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi


###
# Disable the Modular Repos
# Given the added load at updates, and the issues to keep modules updated, in check and listed from the awful cli for it - remove entirely.
###

sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-modular.repo

# Testing Repos should be disabled anyways
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-testing-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo

# Rpmfusion makes this obsolete
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo

# Disable Machine Counting for all repos
# sudo sed -i 's/countme=1/countme=0/g' /etc/yum.repos.d/*

# vscodium, an open source fork of vscode
sudo tee -a /etc/pki/rpm-gpg/vscodium > /dev/null <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=LCWI
-----END PGP PUBLIC KEY BLOCK-----
EOF

printf "[vscodium]\nname=vscodium\nbaseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=file:///etc/pki/rpm-gpg/vscodium" |sudo tee -a /etc/yum.repos.d/vscodium.repo

sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'

###
# Force update the whole system to the latest and greatest
###

sudo dnf upgrade --best --allowerasing --refresh -y "${QUIET}"

# And also remove any packages without a source backing them
sudo dnf distro-sync -y "${QUIET}"

###
# Install base packages and applications
###

sudo dnf group install \
-y \
"${QUIET}" \
php \
fonts \
graphics

sudo dnf install \
-y \
"${QUIET}" \
blender `#3D Software Powerhouse` \
breeze-cursor-theme `#A more comfortable Cursor Theme from KDE` \
calibre `#Ebook management` \
thunderbird `#Mail client` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
file-roller-nautilus `#More Archives supported in nautilus` \
gimp `#The Image Editing Powerhouse - and its plugins` \
gimp-data-extras \
gimp-dbp \
gimp-dds-plugin \
gimp-elsamuko \
gimp-focusblur-plugin \
gimp-fourier-plugin \
gimpfx-foundry.noarch \
gimp-high-pass-filter \
gimp-layer-via-copy-cut \
gimp-lensfun \
gimp-lqr-plugin \
gimp-luminosity-masks \
gimp-paint-studio \
gimp-resynthesizer \
gimp-save-for-web \
gimp-wavelet-decompose \
gimp-wavelet-denoise-plugin \
git \
github-desktop \
gmic-gimp \
gnome-shell-extension-dash-to-dock `#dasechoh for gnome` \
gnome-shell-extension-user-theme `#Enables theming the gnome shell` \
gnome-tweaks `#Your central place to make gnome like you want` \
gource `#Git visualisation` \
gtkhash-nautilus `#View file Hashes via nautilus` \
htop `#Cli process monitor` \
vlc `#Media player` \
openssh-askpass `#Base Lib to let applications request ssh pass via gui` \
pulseeffects `#Tweak your Music!` \
python3-devel `#Python Development Gear` \
tuned `#Tuned can optimize your performance according to metrics. tuned-adm profile powersave can help you on laptops, alot` \
file-roller `#GNOME Archive manager` \
meld `#Quick Diff Tool` \
nano `#Because pressing i is too hard sometimes` \
neofetch `#Pretty system info` \
zsh `#Best shell` \
zsh-syntax-highlighting `#Now with syntax highlighting` \
baobab `#Disk Usage Analyzer` \
nextcloud-client `#Nextcloud Integration for Fedora` \
nextcloud-client-nautilus `#Also for the File Manager, shows you file status` \
sqlite-analyzer `#If you work with sqlite databases` \
sqlitebrowser `#These two help alot`

# # Pulseeffects: Autoenable
# tee -a ~/.config/autostart/pulseeffects-service.desktop > /dev/null <<EOF
# [Desktop Entry]
# Name=PulseEffects
# Comment=PulseEffects Service
# Exec=pulseeffects --gapplication-service
# Icon=pulseeffects
# StartupNotify=false
# Terminal=false
# Type=Application
# EOF
#
# # Pulse: Quality+++
# tee -a ~/.config/pulse/daemon.conf > /dev/null <<EOF
# default-sample-format = float32ne
# default-sample-rate = 48000
# alternate-sample-rate = 44100
# resample-method = speex-float-10
# high-priority = yes
# nice-level = -18
# realtime-scheduling = no
# realtime-priority = 9
# rlimit-rtprio = 9
# avoid-resampling = yes
# EOF

###
# Remove some un-needed stuff
###

if [ "${LAPTOP}" = true ]; then
  sudo systemctl enable --now tuned
  sudo tuned-adm profile balanced
fi

#Performance:
#sudo tuned-adm profile desktop

#Virtual Machine Host:
#sudo tuned-adm profile virtual-host

#Virtual Machine Guest:
#sudo tuned-adm profile virtual-guest

#Battery Saving:
#sudo tuned-adm profile powersave

# Virtual Machines
# sudo systemctl enable --now libvirtd

# Management of local/remote system(s) - available via http://localhost:9090
# sudo systemctl enable --now cockpit.socket
