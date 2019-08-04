#!/bin/bash

# This script toggles between [cz (qwety)] and [us] keyboard
# each time it's called. It's done by keeping a file in ~/.config
# which holds which keyboard is used.
# setxkbmap is used to change keyboard.

if [ ! -f ~/.config/current-keyboard-layout.conf ]; then
	# current keyboard layout is empty
	# set cz, so later the script changes keyboard
	# to us, which is the default one
	touch ~/.config/current-keyboard-layout.conf
	echo 'cz' > ~/.config/current-keyboard-layout.conf
fi

# If there is 'cz' in the file, change it to us and viceversa
if [ "$(cat ~/.config/current-keyboard-layout.conf)" == 'cz' ]; then
	# set keyboard to us
	setxkbmap us
	echo 'us' > ~/.config/current-keyboard-layout.conf
elif [ "$(cat ~/.config/current-keyboard-layout.conf)" == 'us' ]; then
	# set keyboard to cz, qwerty
	setxkbmap cz -variant qwerty
	echo 'cz' > ~/.config/current-keyboard-layout.conf
else
	(>&2 echo "Unknown keyboard layout: $(cat ~/.config/current-keyboard-layout.conf)")
	exit 1
fi

exit 0
