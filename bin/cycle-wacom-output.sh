#!/bin/sh
id=$(xsetwacom list devices | grep 'stylus' | grep -Eo '[0-9]+' | tail -1)

xsetwacom set "$id" MapToOutput next
