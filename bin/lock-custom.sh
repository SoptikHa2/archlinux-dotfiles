#!/bin/bash

trap 'dunstctl set-paused false' EXIT

# Pause notifications
dunstctl set-paused true
# i3 lock with custom image
# This takes ~/archlinux-dotfiles/lockscreen.png and resizes it to resolution detected by xrandr.
# The file is saved into /tmp. If the resolution matches the already generated image, no new image
# is produced and cached version is used instead.
target_resolution="$(xrandr -q | grep -Eo '[0-9]+x[0-9]+' -m 1)"
if [[ ! -f "/tmp/lockscreen-res.txt" ]] || [[ ! "$(grep -q -F "$target_resolution" "/tmp/lockscreen-res.txt")" ]]; then
    convert -resize "$target_resolution" ~/archlinux-dotfiles/lockscreen.png /tmp/lockscreen-tmp.png
    echo "$target_resolution" > /tmp/lockscreen-res.txt
fi
i3lock -i "/tmp/lockscreen-tmp.png" -ue

while [[ $(pgrep 'i3lock' -c) -ge 1 ]]; do
    sleep 5
done
# Notifications will be unpaused when this script exits
