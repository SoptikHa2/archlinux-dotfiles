#!/bin/zsh
set -euo pipefail

# https://github.com/TheWeirdDev/Bluetooth_Headset_Battery_Level
percentage=$(/home/petr/data/Applications/Bluetooth_Headset_Battery_Level/bluetooth_battery.py 1C:52:16:CA:EE:DF.1 | grep -o '[0-9]*%')

echo ": $percentage"
