#!/bin/bash

# Might not be linked
sudo ln -s /var/lib/snapd/snap /snap

if [[ "{$LAPTOP}" = "true" ]]; then
  sudo snap install \
  auto-cpufreq

  # installs auto-cpufreq's daemon
  sudo auto-cpufreq --install
fi
