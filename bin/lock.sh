#!/bin/bash
# Use i3lock with custom image
# Edited https://old.reddit.com/r/i3wm/comments/8hpjb6/i3_lock_screen/
# Requires imagemagick to blur/compose images

screenshot_temp="/tmp/41283721937.screenshot.png"
blurred_temp="/tmp/41283721937.blurred.png"
composite_temp="/tmp/41283721937.composite.png"

revert() {
	rm "$screenshot_temp"
	rm "$blurred_temp"
	rm "$composite_temp"
	xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 0 0 5
maim "$screenshot_temp"
convert -blur 0x8 "$screenshot_temp" "$blurred_temp"
convert "$blurred_temp" "/home/petr/.config/overlay.png" -geometry "70%x70%-270-300" -gravity center -composite "$composite_temp"
i3lock -i "$composite_temp" -ue
revert
