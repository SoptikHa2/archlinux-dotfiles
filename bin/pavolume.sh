#!/bin/bash

# Call with:
# --down to down volume $inc percent (down to 0%)
# --up to up volume $inc percent (up to 100%)
# --mute to mute
# --unmute to unmute
# --togmute to toggle mute
inc=5




activeSink=$(pacmd list-sinks |awk '/* index:/{print $3}')
upLimit=$((100 - ${inc}))
curVol=$(pacmd list-sinks | grep -A 15 'index: '${activeSink}'' | grep '[^base ]volume:' | cut -d: -f 3 | cut -d/ -f 2 | grep -o -E '[0-9]+')
curMutedStatus=$(pacmd list-sinks |grep -A 15 'index: '${activeSink}'' |awk '/muted/{ print $2 }') # yes|no

function volUp {
	if [ $curMutedStatus = 'yes' ]
	then
		volUnmute
	elif [ $upLimit -ge $curVol ]
	then
		pactl set-sink-volume ${activeSink} +${inc}%
	else
		pactl set-sink-volume ${activeSink} 100%
	fi
}

function volDown {
	if [ $curMutedStatus = 'yes' ]
	then
		volUnmute
	elif [ $curVol -ge $inc ]
	then
		pactl set-sink-volume ${activeSink} -${inc}%
	else
		pactl set-sink-volume ${activeSink} 0%
	fi
}

function volMute {
	pactl set-sink-mute ${activeSink} 1
}

function volUnmute {
	pactl set-sink-mute ${activeSink} 0
}

function volToggleMute {
	if [ $curMutedStatus = 'yes' ]
	then
		volUnmute
	else
		volMute
	fi
}

case "$1" in
	--up)
		volUp
		;;
	--down)
		volDown
		;;
	--mute)
		volMute
		;;
	--unmute)
		volUnmute
		;;
	--togmute)
		volToggleMute
		;;
esac
