#!/bin/bash

unpause_notifications() {
  notify-send "DUNST_COMMAND_RESUME"
}

trap 'unpause_notifications' EXIT

# Pause notifications
notify-send "DUNST_COMMAND_PAUSE"
# i3 lock with custom image
i3lock -i "/home/petr/archlinux-dotfiles/lockscreen.png" -ue &
wait
# Notifications will be unpaused when this script exits
