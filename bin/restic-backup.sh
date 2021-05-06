#!/bin/bash
#sftp:sayaka:/home/pi/data/restic-backup
for remote in rclone:FIT-gdrive:restic-backup; do
    echo "Backing up to $remote..."
    restic -r "$remote" backup --one-file-system /home/petr /home/petr/data/{backup,backup-huge,Videos,big,Books,downloads,klimi,photos,Pictures,zoom} --exclude="/home/petr/.*" /home/petr/.ssh /home/petr/.gnupg
done
