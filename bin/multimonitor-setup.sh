#!/bin/bash

internal="eDP-1-1"
external="HDMI-0"

# Allow internal/external override with --internal and --external
for i in "$@"
do
	case $i in
		-i=*|--internal=*)
			internal="${i#*=}"
		;;
		-e=*|--external=*)
			external="${i#*=}"
		;;
		*)
			>&2 echo "Unknown option. Allowed: --internal=<value> (-i=<value>) and --external=<value> (-e=<value>)."
			exit 1
	esac
done

# Turn on monitor:
# --output ... --auto
# Turn off monitor:
# --output ... --off
# Put HDMI right of eDP
# xrandr --output HDMI-0 --right-of eDP-1-1
# Let HDMI and eDP display the same text
# xrandr --output eDP-1-1 --same-as HDMI-0

# Let user choose with rofi dialog
option_internal="int"
option_external="ext"
option_next_to_each_other="[][]"
option_inside_each_other="[[]]"

cancelled=true
chosen="$(echo -e "$option_internal\n$option_external\n$option_next_to_each_other\n$option_inside_each_other" | rofi -theme "monitormenu.rasi" -dmenu)"

case "$chosen" in
	"$option_internal")
		xrandr --output "$internal" --auto
		# Doesn't matter if external doesn't exist
		xrandr --output "$external" --off 2>/dev/null
		cancelled=false
		;;
	"$option_external")
		xrandr --output "$external" --auto
		# Doesn't matter if internal doesn't exist? I guess?
		xrandr --output "$internal" --off 2>/dev/null
		cancelled=false
		;;
	"$option_next_to_each_other")
		echo next as
		xrandr --output "$internal" --auto
		xrandr --output "$external" --auto
		xrandr --output "$external" --right-of "$internal"
		cancelled=false
		;;
	"$option_inside_each_other")
		echo inside
		xrandr --output "$internal" --auto
		xrandr --output "$external" --auto
		xrandr --output "$external" --mode "1920x1080" --same-as "$internal"
		# TODO: Infer resolution of lowest-resolution screen automatically, instead of using hardcoded value
		cancelled=false
esac

if [ "$cancelled" = false ]; then 
	# And fix polybar and wallpaper
	~/archlinux-dotfiles/polybar/launch.sh
	feh --bg-center ~/data/Pictures/wallpaper.png
fi
