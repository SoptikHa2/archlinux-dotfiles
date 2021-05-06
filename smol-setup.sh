#!/bin/bash
set -euo pipefail

cd "$HOME"/archlinux-dotfiles/i3
ln -s config.normal config -f
cd ../x/xorg.conf.d

sed '10 s/#//;11s/Option/#Option/' -i 00-keyboard.conf
