
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
lambda() {
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

# Progtest functions
function g {
    SOURCE="$1"
    
    if [[ -z "$SOURCE" ]]; then
        if [[ -f "main.cpp" ]]; then
            SOURCE="main.cpp"
        elif [[ -f "main.c" ]]; then
            SOURCE="main.c"
        else
            for file in $(find . -maxdepth 1 -name '*.c'); do
                SOURCE="$file"
            done
            for file in $(find . -maxdepth 1 -name '*.cpp'); do
                SOURCE="$file"
            done
        fi
    fi

    g++ --std=c++11 -Wall -pedantic -Wno-long-long -fsanitize=address -g -pg -fPIE "$SOURCE" -o "$SOURCE.bin"
}
function rr {
    BINNAME="main.c.bin"
    if [[ ! -f "main.c.bin" ]]; then
            BINNAME="$1"
            if [[ $BINNAME =~ ^.*\.c$ ]]; then
                BINNAME="$1.bin"
            fi
    fi
    ./"$BINNAME"
}

vg() {
    BINNAME="main.c.bin"
    if [[ ! -f "main.c.bin" ]]; then
            BINNAME="$1"
            if [[ $BINNAME =~ ^.*\.c$ ]]; then
                BINNAME="$1.bin"
            fi
    fi
    valgrind --leak-check=full "./$BINNAME"
}
pt() {
    BINNAME="main.c.bin"
    if [[ -n "$1" ]]; then
        BINNAME="$1"
        if [[ $BINNAME =~ ^.*\.c$ ]]; then
            BINNAME="$1.bin"
        fi
    fi
    for file in sample/CZE/*_in.txt; do
        input_id=${file%_*}
        echo "$input_id"
        d=$(\diff - "$input_id"_out.txt <<<"$("./$BINNAME" <"$file")")
        c=$(wc -c <<<"$d")
        if [[ "$c" -gt 1 ]]; then
            echo "DIFF: $file"
            bat -l diff - <<<"$d"
        fi
    done
}
# Add new test
at() {
(
    set -euo pipefail
    BINNAME="main.c.bin"
    if [[ ! -f "main.c.bin" ]]; then
            BINNAME="$1"
            if [[ $BINNAME =~ ^.*\.c$ ]]; then
                BINNAME="$1.bin"
            fi
    fi

    echo "Enter input for new test. End with EOF (Ctrl+D, maybe multiple times)."
    in="$(cat)"
    out="$("./$BINNAME" <<<"$in")"

    echo "Output:"
    echo "$out"
    echo -e "\nIs this correct? [Y/n]"
    read -r choice
    if [[ "$choice" == "n" ]]; then
        echo "Enter correct output. End with EOF (Ctrl+D, maybe multiple times)."
        out="$(cat)"
    fi
    echo "Test data: (note: this won't test last newline in outputs correctly)"
    printf "%s\n>>>>>>>>%s\n<<<<<<<\n" "$in" "$out"
    echo "Enter test name, enter empty to cancel:"
    read testname
    if [[ -n "$testname" ]]; then
        echo "Saving."
        printf "%s\n" "$in" > sample/CZE/"$testname"_in.txt
        printf "%s\n" "$out" > sample/CZE/"$testname"_out.txt
    fi
)
}

# MS Teams download
destreamer() {
(
cd "$HOME/data/Applications/destreamer" || exit 1
./destreamer.sh -ku stastpe8 -o "$HOME/data/Videos" -i "$1"
)
}
