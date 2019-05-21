#!/bin/bash

# find active sink and output muted status and volume, in this format:
# muted,volume
# Example:
# 0,60
# 1,35
# The first one: sink is NOT muted, volume is 60
# The second one: sink IS muted, volume is 35

# To allow easy usage with polybar, this scripts can output graphical format, if passed as first argument:
# 0 (or nothing) => (see example)
# 1 => 
# 1 => 
# 2 => 60%
# 3 =>  12%

# This script is based on https://customlinux.blogspot.com/2013/02/pavolumesh-control-active-sink-volume.html

active_sink=`pacmd list-sinks |awk '/* index:/{print $3}'`
display=0

# Load display type based on argument
if [ $# -ne 0 ]; then
	display=$1
fi


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


if [ $display -eq 0 ]; then
	echo "$cur_muted,$cur_vol"
elif [ $display -eq 1 ]; then
	if [ $cur_muted -eq 0 ]; then echo ""
	elif [ $cur_muted -eq 1 ]; then echo ""; fi
elif [ $display -eq 2 ]; then
	echo "$cur_vol%"
elif [ $display -eq 3 ]; then
	if [ $cur_muted -eq 0 ]; then echo " $cur_vol%"
	elif [ $cur_muted -eq 1 ]; then echo " $cur_vol%"; fi
fi
