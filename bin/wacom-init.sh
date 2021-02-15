#!/bin/bash

# Initialize wacom tablet settings

padID=$(xsetwacom list devices | grep -i pad | grep -o 'id: [^ \t]*' | tr -d " \t" | cut -d':' -f2)

# Mouse buttons 11 and further. See .xbindkeysrc
xsetwacom set "$padID" Button 1 'f30'
xsetwacom set "$padID" Button 2 'f31'
xsetwacom set "$padID" Button 3 'f32'
#xsetwacom set "$padID" Button 4 f33

