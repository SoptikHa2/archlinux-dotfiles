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
# - awk
#	to parse pactl output, which is
#	horryfyingly anoying to parse.
#	Why not just use json at this point?
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
# Start 5 minute timer, afterwards the video will be
# deleted. Kill the process during those 5 minutes
# for the video to be saved. If the process
# is killed before, the video will be deleted anyways.

# Stop whole script when something fails
# Disable using unset variables when expanding
# (so $DIR/* can never expand to /* if $DIR was unset)
set -eu

# Generate tmp video name
tmp_location="$(mktemp --suffix=".ogv")"
processed_location="$(mktemp --suffix=".ogv")"
rm "$tmp_location" || true
rm "$processed_location" || true
clean_video=1
is_muted=0
kill_rmd_instances=0
if [[ "${1-}" == "--no-sound" ]]; then
	is_muted=1
fi

# When script exits early, cleanup
function cleanup {
	echo "Exiting"
	if [ $clean_video -eq 1 ]; then
		if [ $kill_rmd_instances -eq 1 ]; then
			killall -KILL recordmydesktop || true
		fi
		echo "Clearing $processed_location"
		rm "$processed_location" || true
	fi
	echo "Clearing $tmp_location"
	rm "$tmp_location" || true
}
trap cleanup EXIT


cd ~/archlinux-dotfiles/utilities/record-desktop


# run recordmydesktop
(
	# if not muted, set the sound
	if [ $is_muted -eq 0 ]; then
		# Get active source
		psource=$(awk -f "choose-pactl-source.awk" <<<"$(pactl list sources)")
		echo "Selected Source #$psource"

		# Run recordmydesktop and wait a bit to make sure it initialized
		kill_rmd_instances=1
		recordmydesktop --on-the-fly-encoding -o "$tmp_location" --device pulse &
		sleep 0.8
		# Find recordmydesktop recording ID
		rmdid=$(awk -f "find-recordmydesktop-id.awk" <<<"$(pactl list source-outputs)") || true
		echo "Found recordmydesktop: #$rmdid"
		echo "Executing: pactl move-source-output $rmdid $psource"
		pactl move-source-output "$rmdid" "$psource"
		echo "Set sound to new source"
		wait
	else
		kill_rmd_instances=1
		recordmydesktop --on-the-fly-encoding -o "$tmp_location" --no-sound
	fi
)

# Wait for the subshell to exit, meaning the video is ready
wait
kill_rmd_instances=0

# Cut first second and last two seconds out of the video
#video_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$tmp_location" | cut -d'.' -f1)
#echo "Video duration: $video_duration"
## Cut the video
#echo "Executing ffmpeg -ss 00:00:01 -i $tmp_location -t $((video_duration-4)) -c copy $processed_location"
#ffmpeg -ss 00:00:01 -i "$tmp_location" -t $((video_duration-4)) -c copy "$processed_location"
#rm "$tmp_location" || true
processed_location=$tmp_location

echo "Video is ready: $processed_location"
echo "It will be deleted in 5 minutes."

# Save it to clipboard
#xclip -t video/ogg "$processed_location"
# TODO: Doesn't work. We open it in nemo instead.
# Wait few minutes
clean_video=0
nemo "$processed_location"
sleep $((5 * 60))
clean_video=1

