#!/bin/bash

# This script takes certain folders, tar|7z them, encrypts them, and uploads them via ftps to NAS
# User will be prompted by GPG to enter passphrase

filename_date=$(date +%Y-%m-%d-%H-%M)

removetmp() {
	shred -u -n 1 "/tmp/tmp-backupfile-"$filename_date".tgz"
	rm "/tmp/tmp-backupfile-"$filename_date".tgz.gpg"
}
trap removetmp HUP INT TERM

# Do not backup encrypted folder, as it's large, not updated often, and should be updated manually when changed
# Don't backup AUR, Applications, or Steam either
tar\
	--exclude='/mnt/data/petr/AUR'\
	--exclude='/mnt/data/petr/Applications'\
	--exclude='/mnt/data/petr/Encrypted'\
	--exclude='/mnt/data/petr/SteamLibrary'\
	~/archlinux-dotfiles\
	~/*.txt\
	'/mnt/data/petr'\
	-zcf "/tmp/tmp-backupfile-"$filename_date".tgz"

echo "Packaged files to /tmp/tmp-backupfile-"$filename_date".tgz"
echo "WARNING: /Encrypted DIRECTORY NOT BACKED UP!"

# Now encrypt it
gpg --symmetric "/tmp/tmp-backupfile-"$filename_date".tgz"
# And upload it via ftps (user will be asked for password)
echo "Encrypted. Now, you'll be asked for FTPS password"
lftp -u Petr -e "set ssl:verify-certificate false; cd home; cd backup; put /tmp/tmp-backupfile-"$filename_date".tgz.gpg; exit" mynas

echo "Backup finished. Removing temporary files..."
removetmp
echo "Done"
