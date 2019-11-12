#!/bin/sh

# This script toggles SIGSTOP/SIGCONT and sends signal to firefox
# It can be used with multimedia key play/pause in order to quickly stop
# firefox from playing videos. Whole firefox will freeze unfortunately.

# Get firefox UID
# If you use other browser, change grep
browser_uid=$(pgrep "firefox")

if [ "$browser_uid" = "" ]; then
	1>&2 echo "Error: process not found."
	exit 1
fi

# Test if browser is SIGSTOPped
browser_status=$(ps -o state= -p "$browser_uid")

# If browser signal starts with T, it means browser is currently stopped, probably by this script
# See this for more info: https://askubuntu.com/questions/360252/what-do-the-stat-column-values-in-ps-mean
if [ "$(echo "$browser_status" | grep '^T' -c )" -eq 1 ]; then
	# Send SIGCONT signal to browser
	kill -s CONT "$browser_uid"
else
	# Send SIGSTOP signal to browser
	kill -s STOP "$browser_uid"
fi
