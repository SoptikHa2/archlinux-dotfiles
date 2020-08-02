#!/bin/bash

internal="eDP-1-1"
# Take list of monitors, and filter out the initial heading AND first monitor entry (which SHOULD be $internal). Then take one monitor and get it's name.
#external=$(xrandr --listmonitors | tail -n +3 | head -1 | cut -d' ' -f3 | egrep -o '[a-zA-Z]{1}[a-zA-Z0-9-]*') # HDMI-0
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
        # Set alacritty font to small
        sed -Ei 's/#(size: 9\.0)/\1/' ~/archlinux-dotfiles/alacritty.yml
        sed -Ei 's/(size: 12\.0)/#\1/' ~/archlinux-dotfiles/alacritty.yml
		;;
	"$option_external")
		#xrandr --output "$external" --auto
		xrandr --output "$external" --auto --mode 2560x1440
		# Doesn't matter if internal doesn't exist? I guess?
		xrandr --output "$internal" --off 2>/dev/null
		cancelled=false
        # Set alacritty font to large
        sed -Ei 's/(size: 9\.0)/#\1/' ~/archlinux-dotfiles/alacritty.yml
        sed -Ei 's/#(size: 12\.0)/\1/' ~/archlinux-dotfiles/alacritty.yml
		;;
	"$option_next_to_each_other")
		xrandr --output "$internal" --primary --auto
		xrandr --output "$external" --auto
		xrandr --output "$internal" --right-of "$external"
		cancelled=false
		;;
	"$option_inside_each_other")
		xrandr --output "$internal" --auto
		xrandr --output "$external" --auto
		xrandr --output "$external" --mode "1920x1080" --same-as "$internal"
		# TODO: Infer resolution of lowest-resolution screen automatically, instead of using hardcoded value
		cancelled=false
esac

if [ "$cancelled" = false ]; then 
	# And fix polybar and wallpaper
	~/archlinux-dotfiles/polybar/launch.sh
	feh --bg-fill ~/archlinux-dotfiles/wallpaper.jpg
fi
