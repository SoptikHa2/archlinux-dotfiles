#!/bin/bash
source "$HOME/archlinux-dotfiles/bin/secret"


# Launch rofi. Either connection to wifi can be selected, to ethernet, or
# turn on Alza VPN.

option_wifi=""
option_ethernet=""
option_vpn=""

chosen="$(echo -e "$option_wifi\n$option_ethernet\n$option_vpn" | rofi -theme "networkmenu.rasi" -dmenu)"

case $chosen in
	$option_wifi)
		sudo ip link set wlp2s0 up
		;;
	$option_ethernet)
		sudo ip link set wlp2s0 down
		sudo netctl switch-to ethernet
		sudo dhcpcd enp0s20f0u1u4
		;;
	$option_vpn)
		terminator -x "source /home/petr/.zshrc && sudo openconnect $vpn_address -c $vpn_cert -k $vpn_key"
esac
