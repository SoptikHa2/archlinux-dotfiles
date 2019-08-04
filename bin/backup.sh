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
	~/archlinux-dotfiles\
	~/*.txt\
	~/*.pdf\
	~/Documents\
	~/Downloads\
	'/mnt/data/petr'\
	-zcf "/tmp/tmp-backupfile-$filename_date.tgz"

echo "Packaged files to /tmp/tmp-backupfile-$filename_date.tgz"
echo "WARNING: /Encrypted DIRECTORY NOT BACKED UP!"

# Now encrypt it
gpg --symmetric "/tmp/tmp-backupfile-$filename_date.tgz"
echo "Encrypted. Deleting plaintext archive..."
# Delete plaintext archive
shred -u -n 1 "/tmp/tmp-backupfile-$filename_date.tgz"
# And upload the encrypted archive via ftps (user will be asked for password)
echo "Deleted. Enter your FTPS password"
lftp -u Petr -e "set ssl:verify-certificate false; cd home; cd backup; put /tmp/tmp-backupfile-$filename_date.tgz.gpg; exit" mynas

echo "Backup finished. Removing temporary files..."
removetmp
echo "Done"
