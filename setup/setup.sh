#!/bin/zsh
set -euo pipefail

echo Overwriting /etc/profile
sudo cp ../x/profile /etc/profile
echo Installing packages
./install-packages.sh packages.common
echo Installing mandatory AUR packages
./prepare-aur.sh
echo Setting up symlinks
./config-symlinks.sh
echo Setting up firefox
./setup-firefox.sh
