#!/bin/bash
set -euo pipefail

cd "$HOME"/archlinux-dotfiles/i3
ln -s config.moonlander config -f
cd ../x/xorg.conf.d

sed '11 s/#//;10s/Option/#Option/' -i 00-keyboard.conf
