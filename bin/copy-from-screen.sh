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

set -eu

text=$(maim -s | tesseract - - | sed -E '/^\s*$/ d')
if [ -z "$text" ]; then
    exit 1
fi
echo "$text" | xclip -selection clipboard
if command -v notify-send; then
    notify-send -u low "Screenshot OCR" "$text"
fi
