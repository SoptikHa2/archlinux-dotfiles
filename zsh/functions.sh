
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
echo "$1" | gpg --hidden-recipient "$2" --armor --encrypt - | xclip
}
