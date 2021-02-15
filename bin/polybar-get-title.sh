#!/bin/sh

# Get window title or, if pomodoro is running, grab the pomodoro timer
if [[ $(pgrep -c pomodoro) -ge 1 ]]; then
    windowname="$(xdotool getwindowname "$(xdotool search --sync --name "([0-9]?([0-9]m))? ?([0-9]?([0-9]s))")")"
    status="$(cat ~/.cache/soptik-pomodoro)"
    echo "$status $windowname"
else
    xdotool getwindowfocus getwindowname | cut -c -80
fi
