#!/bin/bash
# First parameter: Directory
set -e

if [ ! -d "$1" ]; then
	echo "Please provide a directory to encrypt"
	exit 1
fi

tar -cvzf "$1".tar.gz "$1"
echo "Encrypting..."
gpg -r petr.stastny01@gmail.com --encrypt "$1".tar.gz
echo "Shredding..."
shred -u -n1 "$1".tar.gz
find "$1" -type f -exec shred {} \;
echo "Removing..."
rm -rf "$1"
