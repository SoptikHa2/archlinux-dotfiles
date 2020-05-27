#!/bin/bash
set -e

if [ ! -f "$1" ]; then
	echo "Please provide encrypted file as first paramter."
	exit 1
fi
if [ -d "$2" ]; then
	echo "Please provide target directory name that doesn't exist yet as second parameter."
	exit 2
fi

gpg --decrypt "$1" > "$1.decrypted"
mkdir "$2"
tar -xzvf "$1.decrypted"
rm "$1"
shred -u -n1 "$1.decrypted"
