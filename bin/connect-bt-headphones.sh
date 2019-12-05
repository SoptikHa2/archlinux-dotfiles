#!/bin/bash

headphones_mac="F5:F7:84:B5:C3:D4"
dongle_mac="00:1A:7D:DA:71:03"

bluetoothctl << EOF
	select $dongle_mac
	power on
	connect $headphones_mac
EOF
