#!/bin/sh
maim -us /tmp/"$USER"screenshot.png
xclip -selection clipboard -t image/png </tmp/"$USER"screenshot.png
notify-send "Screenshot /tmp/""$USER""screenshot.png copied to clipboard"
