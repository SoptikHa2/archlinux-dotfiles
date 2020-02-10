#!/bin/bash
# First parameter: Directory
set -e

if [ ! -d "$1" ]; then
	echo "Please provide a directory to encrypt"
	exit 1
fi

tar -cvzf Journal.tar.gz Journal/
gpg -r petr.stastny01@gmail.com --encrypt Journal.tar.gz
shred -u -n1 Journal.tar.gz
find Journal -type f -exec shred {} \;
rm -rf Journal
