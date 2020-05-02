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
        rofi-wifi-menu
		;;
	$option_ethernet)
        # TODO
		;;
	$option_vpn)
        if [[ $(nmcli connection show --active | grep "Alza VPN" -c) -eq 0 ]]; then
            nmcli connection up "Alza VPN"
        else
            nmcli connection down "Alza VPN"
        fi
esac
