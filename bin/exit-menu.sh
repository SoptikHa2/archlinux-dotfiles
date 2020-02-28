#!/bin/bash
# Ask user whether he wants to lock, logout, poweroff, reboot, or boot into UEFI menu

# Let user choose with rofi dialog
option_poweroff="Poweroff"
option_reboot="Reboot"
option_lock="Lock"
option_logout="Logout"
option_uefi="UEFI menu"

chosen="$(echo -e "$option_poweroff\n$option_reboot\n$option_lock\n$option_logout\n$option_uefi" | rofi -theme exitmenu.rasi -location 7 -dmenu)"

case "$chosen" in
	"$option_poweroff")
		systemctl poweroff
		;;
	"$option_reboot")
		systemctl reboot
		;;
	"$option_lock")
		lock-custom
		;;
	"$option_logout")
		i3-msg exit
		;;
	"$option_uefi")
		systemctl reboot --firmware-setup
esac
