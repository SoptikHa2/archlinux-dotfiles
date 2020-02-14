#!/bin/bash
# First parameter: Directory
set -e

if [ ! -d "$1" ]; then
	echo "Please provide a directory to encrypt"
	exit 1
fi

tar -cvzf "$1".tar.gz "$1"
gpg -r petr.stastny01@gmail.com --encrypt "$1".tar.gz
shred -u -n1 "$1".tar.gz
find "$1" -type f -exec shred {} \;
rm -rf "$1"
