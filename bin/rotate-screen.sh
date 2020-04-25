#!/bin/bash

# This script accepts one parameter: xrandr-like display orientation

# This not only calls xrandr, but also changes laptop touchpad orientation for
# easy usage
target_screen="eDP-1-1"
# You can find this out by using $(xinput)
target_touchpad="ELAN469D:00 04F3:304B Touchpad"

if [ -z "$1" ]; then
	echo "Unknown orientation. Expected usage: $ rotate-screen.sh <left|right|normal|inverted>"
	exit 1
fi

transformation_matrix=""
if [ "$1" == "normal" ]; then
	transformation_matrix="0 0 0 0 0 0 0 0 0"
elif [ "$1" == "inverted" ]; then
	transformation_matrix="-1 0 1 0 -1 1 0 0 1"
elif [ "$1" == "left" ]; then
	transformation_matrix="0 -1 1 1 0 0 0 0 1"
elif [ "$1" == "right" ]; then
	transformation_matrix="0 1 0 -1 0 1 0 0 1"
else
	echo "Uknown orientation. Expected usage: $ rotate-screen.sh <left|right|normal|inverted>"
	exit 1
fi

xrandr --output "$target_screen" --rotation "$1"
xinput set-prop "$target_touchpad" --type=float "Coordinate Transformation Matrix" $transformation_matrix

# Relaunch polybar so it adapts to new screen dimensions
~/archlinux-dotfiles/polybar/launch.sh
