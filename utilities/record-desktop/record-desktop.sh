#!/bin/bash

# Record desktop and save it into clipboard
# This forces computer output to be recorded
# as sound.
#
# Pass --no-sound flag for obvious effect.
#
# This uses following dependencies:
# - recordmydesktop
#	for the actual recording
# - pactl
#	for managing sound when recording
# - ffmpeg
#	for cutting the resulting video
# - notify-send
#	for sending notification when everything
#	is finished and video is in clipboard
# - haskell (specifically 'runhaskell' binary)
#	because I'm lazy and haskell is cool
#	all used haskell scripts can be found in
#	archlinux-dotfiles/utilities/record-desktop/
#
# See also stop-desktop-recording.sh

# Process:
# Launch record-dekstop in async subshell
# Wait one second for it to initialize (ugly, I know),
# then change recording sound to monitor of output.
# When recording is cancelled, wait for it to render.
# When it is recorded, cut the first 2 seconds and
# last 3 seconds and copy the video into clipboard
# Display notification
# Start 5 minute timer, afterwards, if this process is not killed,
# it will delete the resulting video. If this process is terminated
# before this stage, the video will be deleted regardless.
