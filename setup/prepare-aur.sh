#!/bin/zsh
set -euo pipefail

mkdir AUR -p
for package in polybar nerd-fonts-complete; do
	cd ~
	cd AUR
	git clone https://aur.archlinux.org/$package.git
	cd $package
	makepkg -si
done
