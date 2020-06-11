#!/bin/sh
# Requirements:
#   maim
#   tesseract
#   sed
#   xclip
#   notify-send (optional)
#
# This script allows user to select a screen area, screenshots it,
# OCRs it, and saves it into clipboard
#
# $1 : optional : language to use
#   see $(tesseract --list-langs)

tes_command="tesseract - -"
if [ -n "$1" ]; then
    tes_command="tesseract -l $1 - -"
fi

set -eu

text=$(maim -s | $tes_command | sed -E '/^\s*$/ d')
if [ -z "$text" ]; then
    exit 1
fi
echo "$text" | xclip -selection clipboard
if command -v notify-send; then
    notify-send -u low "Screenshot OCR" "$text"
fi
