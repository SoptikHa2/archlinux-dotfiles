#!/bin/zsh
# This generates new journal entry
set -euo pipefail

err() { printf "$0[ERROR]: %s\n" "$*" >&2 }

(
cd ~/data/ || exit 1
# First, let's see if the journal is decrypted. If not, try to decrypt it.
if [ ! -d Journal ]; then
    # Decrypt it
    if [ -e Encrypted.tar.gz.gpg ]; then
        unlock Journal.tar.gz.gpg Journal/
        if [ ! -d Journal ]; then
            err "Failed to decrypt journal."
            exit 2
        fi
    else
        err "Cannot find encrypted journal file."
        exit 3
    fi
fi

# At this point, Journal is there. Let's go there
cd Journal/text || exit 1

# Get today's date
date=$(date +'%Y-%m-%d')
filename="$date.md"

# Check if the file doesn't exist already
while [ -e "$filename" ]; do
    # Ask user for new filename
    echo "Warning: file »$filename« already exists. What should the new filename be called?"
    echo "Press <C-c> to exit."
    echo "Make sure the new filename ends with .md so it compiles automagically."
    echo "Enter OVERWRITE-THE-FILE to overwrite the file."
    read new_filename
    if [[ "$new_filename" == "OVERWRITE-THE-FILE" ]]; then
        cat "$filename"
        echo "Do you really want to overwrite the file? [y/N]"
        read choice_overwrite
        if [[ "$choice_overwrite" == "y" ]]; then
            rm "$filename"
        fi
    else
        filename="$new_filename"
    fi
done

# Create the file
cp template.md "$filename"

# Edit the template file. It contains placeholders:
# <<INSERT-DATE-HERE>>, to be replaced with something like: 2020-05-10
# <<HUMAN-DATE-HERE>>, to be replaced with something like: Neděle 10. května 2020
sed 's/<<INSERT-DATE-HERE>>/'"$date"'/' "$filename" | sponge "$filename"
sed 's/<<HUMAN-DATE-HERE>>/'"$(LC_TIME=cs_CZ.UTF-8 date +'%A %d. %B %Y')"'/' "$filename" | sponge "$filename"

# Edit the file
nvim "$filename" || vim "$filename" || nano "$filename" || ed "$filename"
)
