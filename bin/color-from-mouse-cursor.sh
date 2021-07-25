#!/bin/bash

x=0
y=0

loc="$(xdotool getmouselocation)"
x=$(grep -Eo 'x:[^ ]+' <<<"$loc" | tr -d 'x:')
y=$(grep -Eo 'y:[^ ]+' <<<"$loc" | tr -d 'y:')

color=$(maim -u -g 1x1+$x+$y | convert - -format '%[pixel:s]\n' info:- | awk -F '[(,)]' '{printf("#%x%x%x\n",$2,$3,$4)}')

notify-send 'Color at mouse pointer' "$color"
echo "$color" | xclip -selection clipboard -i
