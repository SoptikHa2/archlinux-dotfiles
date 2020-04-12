#!/bin/bash
ascii_table=$(ascii -x -t | sed -E 's/( ){3,}/\n/g' | awk '$0 !~ "^$" { print $0 }')

string_to_encode=$1


grep -o . <<< "$string_to_encode" | while read -r letter; do
	if [ "$letter" == "" ]; then
		printf "%%20"
	else
		printf "%%%s" "$(echo "$ascii_table" | grep -F "$letter" - | cut -d' ' -f1)"
	fi
done

printf "\n"
