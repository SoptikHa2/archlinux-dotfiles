#!/bin/sh
id=$(xsetwacom list devices | grep 'stylus' | grep -Eo '[0-9]+' | tail -1)

# Reset orientation
xsetwacom set "$id" Rotate none
xsetwacom set "$id" MapToOutput next
