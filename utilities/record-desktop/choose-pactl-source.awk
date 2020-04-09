# Load pactl source and choose one to be used as recording source
#
# They are chosen at this priority order:
# - Has [State: RUNNING]			16p
# - Has [Mute: no]				8p
# - Has [device.form_factor = "headphone"]	4p
# - Has [device.bus = "bluetooth"]		2p
# - Has [device.class = "sound"]		1p
# - Has high ID					0p
#
# Each device gets some amount of points, and the highest amount of points with highest ID wins.
# Id of the selected device is displayed afterwards

BEGIN { 
	currentDeviceIdx = 0;
	# Separate by #. This is used to get source id's, since it's the only place relevant to use where # is used.
	# It looks like this: ^Source #3$
	FS = "#";
}

# On beginning of new source
/Source #[0-9]+/ {
	SOURCE_IDS[currentDeviceIdx] = $2;
}

# On empty line, increment device idx
/^$/ {
	currentDeviceIdx += 1;
}

# Match rules above and award points
/State: RUNNING/ { SOURCE_POINTS[currentDeviceIdx] += 16; }
/Mute: no/ { SOURCE_POINTS[currentDeviceIdx] += 8; }
/device\.form_factor = "headphone"/ { SOURCE_POINTS[currentDeviceIdx] += 4; }
/device\.bus = "bluetooth"/ { SOURCE_POINTS[currentDeviceIdx] += 2; }
/device\.class = "sound"/ { SOURCE_POINTS[currentDeviceIdx] += 1; }

END {
	winningId = -1;
	winningPoints = -1;
	for(i = 0; i <= currentDeviceIdx; i++) {
		if (SOURCE_POINTS[currentDeviceIdx] >= winningPoints) {
			winningId = SOURCE_IDS[currentDeviceIdx];
			winningPoints = SOURCE_POINTS[currentDeviceIdx];
		}
	}
	print winningId
}
