#!/bin/bash

if [[ "{$LAPTOP}" = "true" ]]; then
  sudo snap install \
  auto-cpufreq

  # installs auto-cpufreq's daemon
  sudo auto-cpufreq --install
fi
