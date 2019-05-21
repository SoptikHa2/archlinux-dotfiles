#!/bin/bash

# find active sink and output muted status and volume, in this format:
# muted,volume
# Example:
# 0,60
# 1,35
# The first one: sink is NOT muted, volume is 60
# The second one: sink IS muted, volume is 35

# This script is based on https://customlinux.blogspot.com/2013/02/pavolumesh-control-active-sink-volume.html

active_sink=`pacmd list-sinks |awk '/* index:/{print $3}'`

function getCurVol {
	cur_vol=`pacmd list-sinks |grep -A 15 'index: '${active_sink}'' |grep 'volume:' |egrep -v 'base volume:' |awk -F : '{print $3}' |grep -o -P '.{0,3}%'|sed s/.$// |tr -d ' '`
}

function getCurMutedStatus {
	cur_muted=`pacmd list-sinks |grep -A 15 'index: '${active_sink}'' |grep 'muted:' |awk -F : '{print $2}'`
	if [ "$cur_muted" == " yes" ]
	then
		cur_muted=1
	else
		cur_muted=0
	fi
}

getCurVol
getCurMutedStatus

echo "$cur_muted,$cur_vol"
