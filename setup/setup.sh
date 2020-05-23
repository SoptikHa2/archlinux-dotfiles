#!/bin/zsh
set -euo pipefail

echo Overwriting /etc/profile
cp ../x/profile /etc/profile
echo Installing packages
./install-packages.sh
echo Installing mandatory AUR packages
./prepare-aur.sh
echo Setting up symlinks
./config-symlinks.sh
