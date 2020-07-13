#!/bin/bash

unpause_notifications() {
  notify-send "DUNST_COMMAND_RESUME"
}

trap 'unpause_notifications' EXIT

# Pause notifications
notify-send "DUNST_COMMAND_PAUSE"
# i3 lock with custom image
i3lock -i "/home/petr/archlinux-dotfiles/lockscreen.png" -ue

while [[ $(pgrep 'i3lock' -c) -ge 1 ]]; do
    sleep 5
done
# Notifications will be unpaused when this script exits
