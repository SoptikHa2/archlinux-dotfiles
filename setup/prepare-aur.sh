#!/bin/zsh
set -euo pipefail

mkdir ~/AUR -p
for package in polybar ttf-font-awesome-4; do
	cd ~/AUR
	git clone https://aur.archlinux.org/$package.git
	cd $package
	makepkg -si
done
