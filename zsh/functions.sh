
# Call cheat.sh with $1 and strip all ANSI color codes.
# Ideal for pasting into vim with :.!
cheatsh () {
	# Call cheat.sh silently (without progressbar)
	curl cheat.sh/"$1" -s \
	| sed 's/\x1B\[[0-9;]*[JKmsu]//g'
	# And remove all ansi color codes
	# Credit: https://unix.stackexchange.com/questions/55546/removing-color-codes-from-output#55547
}


# Decrypt from clipboard
declip () {
xclip -o | gpg -d
}

# Encrypt from "$1" for user "$2" and save to clipboard
enclip () {
text="$1"
recipient="$2"
if [ -z "$text" ]; then
    text=$(echo "Message to encrypt" | rofi -dmenu)
    if [ -z "$text" ]; then return; fi
fi
if [ -z "$recipient" ]; then
    recipient=$(gpg --list-public-keys | awk '
BEGIN { FS="] " }
/^pub/ { status=1 }
/^ / { if (status == 1) { fingerprint=gensub(/ /, "", "g", $1); status=2 } }
/^uid/ { if (status == 2) { status = 0; print fingerprint " " $2 } }' | rofi -dmenu -i | cut -d" " -f1)
    if [ -z "$recipient" ]; then return; fi
fi
echo "$text" | gpg --recipient "$recipient" --armor --encrypt - | xclip
}

# If invoked without arguments, repeat last command with sudo.
# If invoked with arguments, act as alias to sudo.
please () {
    if [ $# -ge 1 ]; then
        sudo "$@"
    else
        # Safety: we need to split the command in history
        # in order to separate command and arguments.
        # Note that this command breaks if we use it to
        # process commands with spaces or something like that,
        # but that's the price we need to pay.
        # shellcheck disable=SC2046
        sudo $(fc -ln -1)
    fi
}
