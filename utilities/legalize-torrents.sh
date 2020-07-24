#!/bin/bash
set -euo pipefail

# <legalize-torrents.sh>
# This script receives pre-up events from NetworkManager
# (see networkmanager(8).dispatcher_scripts) and changes
# transmission torrents. 
#
# In ~/.config/transmission, there is expected to be
# torrents_legal directory, that replaces usual 'torrents'
# directory that transmission reads. The usual directory ('torrents')
# is replaced when user is connected to "eduroam" profile and
# is switched back the moment user connects to another AP.
#
# One can override this behaviour (for debugging purposes)
# by passing --legal or --illegal as $1.
#
# This file is supposed to be placed in (or symlinked to)
# /etc/NetworkManager/dispatcher.d/pre-up.d
# where only root can write to this, it's executable
# and does NOT have setuid bit.
#
# Hint: move all your legal torrents to the
# torrents_legal, and symlink them to the illegal
# folder as well (so you're seeding all your torrents
# when in illegal mode: ln -s path/to/legal/.torrent path/to/illegal

TRANSMISSION_ROOT="$HOME/.config/transmission"

removelock() {
    rm ~/.config/transmission/.transmission-torrents.lock
}
kill_transmission() {
    # Make sure transmission is not running. Send SIGTERM and SIGKILL after 0.5s
    # after not quiting
    pid=$(pgrep transmission)
    # Make sure to use the kill executable and not shell one!
    /usr/bin/kill --timeout 500 KILL --signal TERM "$pid"
}

# Check for NM event
ifname=$1
nmaction="none"
debug=0
if [[ "$1" == "--legal" ]]; then
    debug=1
elif [[ "$1" == "--illegal" ]]; then
    debug=2
else
    nmaction=$2
fi
if [[ "$nmaction" != "pre-up" && $debug -eq 0 ]]; then
    exit 0
fi

apname="none"
if [ $debug -eq 0 ]; then
    apname=$(nmcli device show "$ifname" | grep 'GENERAL.CONNECTION' | awk '{print $2}')
fi

if [ ! -d "$TRANSMISSION_ROOT" ]; then
    echo "transmission-torrents: error: $TRANSMISSION_ROOT not found."
    exit 1
fi

# Check for lock file. Yeah, this won't work all the time, but it's
# better than nothing. Sometimes NM connects and disconnects interfaces
# way too quick. We don't want to run this script multiple times in
# parallel!
if [ -f "$TRANSMISSION_ROOT/.transmission-torrents.lock" ]; then
    echo "transmission-torrents: error: lock file found."
    exit 2
fi

trap 'removelock' EXIT
touch "$TRANSMISSION_ROOT/.transmission-torrents.lock"

# Create torrents_legal if it doesn't exist
mkdir -p "$TRANSMISSION_ROOT/torrents_legal"

# If transmission is running, grab it's executable name so we can launch it later
transmission_name=$(pgrep -a 'transmission' | awk '{print $2}')

if [ "$apname" == "eduroam" ] || [ $debug -eq 1 ]; then
    # Check if we have work to do
    if [ -L "$TRANSMISSION_ROOT/torrents" ]; then
        exit 0
    fi

    kill_transmission || true

    mv "$TRANSMISSION_ROOT/torrents" "$TRANSMISSION_ROOT/.torrents_illegal"
    ln -s "$TRANSMISSION_ROOT/torrents_legal" "$TRANSMISSION_ROOT/torrents"
else
    # Check if we have work to do
    if [ ! -L "$TRANSMISSION_ROOT/torrents" ]; then
        exit 0
    fi

    kill_transmission || true

    rm "$TRANSMISSION_ROOT/torrents"
    mv "$TRANSMISSION_ROOT/.torrents_illegal" "$TRANSMISSION_ROOT/torrents"
fi

if [ -n "$transmission_name" ]; then
    exec "$transmission_name" >/dev/null 2>&1 &
    disown
fi
