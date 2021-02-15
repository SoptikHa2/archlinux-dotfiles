#!/bin/sh

id=$(xsetwacom list devices | grep 'stylus' | grep -Eo '[0-9]+' | tail -1)

xsetwacom set "$id" MapToOutput 1720x1412+1720-0
xsetwacom set "$id" Rotate ccw
