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
# Try to make the folder, just to see if it works.
# Delete it afterwards, we will create it later.
mkdir "$2" || (
    echo "Failed to create directory »$2«. Did you enter valid name?"
    exit 3
)

gpg --decrypt "$1" > "$1.decrypted"
mkdir "$2"
tar -xzvf "$1.decrypted"
rm "$1"
shred -u -n1 "$1.decrypted"
