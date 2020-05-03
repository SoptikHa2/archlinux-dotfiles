#!/bin/zsh
source "$HOME/archlinux-dotfiles/bin/secret"


# Launch rofi. Either connection to wifi can be selected, to bluetooth, or
# turn on Alza VPN.

option_wifi=""
option_bluetooth=""
option_vpn=""

chosen="$(echo -e "$option_wifi\n$option_bluetooth\n$option_vpn" | rofi -theme "networkmenu.rasi" -dmenu)"

case $chosen in
	$option_wifi)
        rofi-wifi-menu
		;;
	$option_bluetooth)
        # Make sure bluetoothd is enabled
        # https://www.linuxquestions.org/questions/programming-9/control-bluetoothctl-with-scripting-4175615328/
        coproc bluetoothctl
        echo -e 'power on\n connect 1C:52:16:CA:EE:DF\nexit\n' >&p
        sleep 3
		;;
	$option_vpn)
        if [[ $(nmcli connection show --active | grep "Alza VPN" -c) -eq 0 ]]; then
            nmcli connection up "Alza VPN"
        else
            nmcli connection down "Alza VPN"
        fi
esac
