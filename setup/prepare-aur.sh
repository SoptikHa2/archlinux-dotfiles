#!/bin/zsh
set -euo pipefail

mkdir ~/AUR -p
for package in polybar; do
	cd ~/AUR
	git clone https://aur.archlinux.org/$package.git
	cd $package
	makepkg -si
done
