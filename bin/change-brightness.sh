#!/bin/sh

# Assuming curent user uses inteL_backlight and has access to /sys/class/backlight/intel_backlight/{brightness,max_brightness}.
# This can be set for even non-root users by adding rule:
# < /etc/udev/rules.d/30-brightness.rules >
# KERNEL=="intel_backlight", SUBSYSTEM=="backlight", RUN+="/usr/bin/find /sys/class/backlight/intel_backlight/ -type f -name brightness -exec chown petr:petr {} ; -exec chmod 666 {} ;"

# Pass either 0 to decrease or 1 to increase brightness (as first argument)

max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
new_brightness=0
brightness_step=200

if [ "$1" -eq 0 ]; then
	new_brightness=$((current_brightness - brightness_step))
fi
if [ "$1" -eq 1 ]; then
	new_brightness=$((current_brightness + brightness_step))
fi

if [ "$new_brightness" -lt 5 ]; then
	exit 1
fi
if [ "$new_brightness" -ge "$max_brightness" ]; then
	exit 1
fi

echo $new_brightness > /sys/class/backlight/intel_backlight/brightness
