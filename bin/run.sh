#!/bin/zsh

source ~/archlinux-dotfiles/zsh/*.sh

lastOutput=""
cmd=""
while true; do
	cmd=$(rofi -dmenu <<<$(printf "$cmd\n$lastOutput"))
	if [ -z "$cmd" ]; then
		exit 0
	fi
	lastOutput=$(eval "$cmd")
	echo "=== OUTPUT ==="
	echo "$lastOutput"
done
