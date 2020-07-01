
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

# Encrypt message "$1" for user "$2" and save to clipboard
enclip () {
text="$1"
recipient="$2"
if [ -z "$text" ]; then
    text=$(rofi -dmenu -p "Message to encrypt")
    if [ -z "$text" ]; then return; fi
fi
if [ -z "$recipient" ]; then
    recipients=$(gpg --list-public-keys | awk '
BEGIN { FS="] " }
/^pub/ { status=1 }
/^ / { if (status == 1) { fingerprint=gensub(/ /, "", "g", $1); status=2 } }
/^uid/ { if (status == 2) { status = 0; print fingerprint " " $2 } }')
    recipient_idx=$(echo "$recipients" | cut --complement -d" " -f1 | rofi -dmenu -i -p "Recipient" -format i)
    if [ -z "$recipient_idx" ]; then return; fi
    recipient=$(echo "$recipients" | sed -n "$((recipient_idx+1))p" | cut -d" " -f1)
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

# Lambda: duplicates stdin and saves it into usable variable
# Example:
# printf 'abc def\nghi\n' | lambda x | wc -l; wc -w <<<$x
# 2
# 3
function lambda {
	# We need at least one argument to be useful
	if [[ $# -le 0 ]]; then
		echo "lambda: warn: Specify at least one variable in which will be copied stdin." >&2
	fi

	# Empty variable that will be used to store stdin
	lambda_function_internal__stdin_collected=""
	# Read stdin
	while IFS="" read -r lambda_function_internal__STDIN; do
		# For each line of input, append it to collected stdin with a newline
		lambda_function_internal__stdin_collected="$lambda_function_internal__stdin_collected$lambda_function_internal__STDIN\n"
	done
	# Remove last newline (that shouldn't be there) from collected stdin
	lambda_function_internal__stdin_collected="$(echo $lambda_function_internal__stdin_collected | sed 'x;2,$p' -n)"

	# Save the collected stdin to variable specified by user
	
	# Save stdin into the variable
	# Typeset cannot be used here, since the variable would be local only afterwards.
	# DANGER!! POTENTIAL CODE EXECUTION VULNERABILITY!!
	for lambda_function_internal__variable_name in "$@"; do
		eval "$lambda_function_internal__variable_name='$lambda_function_internal__stdin_collected'"
	done

	# Output captured stdin
	echo $lambda_function_internal__stdin_collected
}
