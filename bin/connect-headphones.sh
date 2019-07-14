#!/bin/bash

# enable bluetooth
sudo systemctl start bluetooth

# wait for it to load
sleep 1

# and connect

#                  select usb dongle        connect to P6
echo -e 'power on\nselect 00:1A:7D:DA:71:03\nconnect F5:F7:84:B5:C3:D4\nquit' | bluetoothctl
