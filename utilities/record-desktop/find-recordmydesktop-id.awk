
BEGIN { 
	# Separate by #. This is used to get source id's, since it's the only place relevant to use where # is used.
	# It looks like this: ^Source #3$
	FS = "#";
}

# On beginning of new source
/Source Output #[0-9]+/ {
	latestId = $2;
}

/application\.process\.binary = ".*recordmydesktop.*"/ {
	print(latestId);
	exit 0;
}

END {
	exit 1;
}
