#!/bin/bash

# This script takes certain folders, tar|7z them, encrypts them, and uploads them via ftps to NAS
# User will be prompted by GPG to enter passphrase

filename_date=$(date +%Y-%m-%d-%H-%M)

removetmp() {
	# Shred plaintext file and remove encrypted file.
	
	# Unless something bad happens, the plaintext file should not exist
	# when this is called. So we can just silence shred to not warn us the
	# file doesn't exist
	shred -u -n 1 "/tmp/tmp-backupfile-$filename_date.tgz" 2>/dev/null
	rm "/tmp/tmp-backupfile-$filename_date.tgz.gpg"
}
trap removetmp HUP INT TERM

echo "Archiving and compressing..."

# Do not backup encrypted folder, as it's large, not updated often, and should be updated manually when changed
# Don't backup AUR, Applications, Torrent, or Steam either
tar\
	--exclude='/mnt/data/petr/AUR'\
	--exclude='/mnt/data/petr/Applications'\
	--exclude='/mnt/data/petr/Encrypted'\
	--exclude='/mnt/data/petr/SteamLibrary'\
	--exclude='/mnt/data/petr/Torrent'\
	--exclude='/mnt/data/petr/data-collection'\
	--exclude='/mnt/data/petr/tmp'\
	--exclude="/mnt/data/petr/*.gpg"\
	~/archlinux-dotfiles\
	~/*.txt\
	~/*.pdf\
	~/Documents\
	~/Downloads\
	~/Utilities\
	'/mnt/data/petr'\
	-zcf "/mnt/data/petr/tmp/tmp-backupfile-$filename_date.tgz"

echo "Packaged files to /tmp/tmp-backupfile-$filename_date.tgz"
echo "WARNING: /Encrypted DIRECTORY NOT BACKED UP!"

# Now encrypt it
gpg --symmetric "/mnt/data/petr/tmp/tmp-backupfile-$filename_date.tgz"
echo "Encrypted. Deleting plaintext archive..."
# Delete plaintext archive
shred -u -n 1 "/mnt/data/petr/tmp/tmp-backupfile-$filename_date.tgz"
if [ -z "$1" ] && [ "$1" == "--ftp" ]; then
	# And upload the encrypted archive via ftps (user will be asked for password)
	echo "Enter your FTPS password"
	lftp -u Petr -e "set ssl:verify-certificate false; cd home; cd backup; put /tmp/tmp-backupfile-$filename_date.tgz.gpg; exit" mynas
else
	# Save encrypted file to ~/data in case user wants to upload the file somewhere
	mv "/tmp/tmp-backupfile-$filename_date.tgz.gpg" ~/data/
	echo "Saved backup file to ~/data/tmp-backupfile-$filename_date.tgz.gpg"
	echo "Upload the file somewhere if you wish and delete it later."
fi

echo "Backup finished. Removing temporary files..."
removetmp
echo "Done"
