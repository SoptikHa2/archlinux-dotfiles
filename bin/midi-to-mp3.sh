#!/bin/bash
# Dependencies:
# jack
# fluidsynth
# /usr/share/soundfonts/FluidR3_GM.sf2 (or other, edit source code)
# (you can get soundfont from package soundfont-fluid)
# twolame
#
# This script takes file name (without extension),
# searches for it in ~/MIDI_recorder/Recordings (in .mid format)
# and converts it to $2

fluidsynth -l -T raw -F - /usr/share/soundfonts/FluidR3_GM.sf2 ~/MIDI_recorder/Recordings/"$1".mid| twolame -b 256 -r - "$2"
