#!/bin/bash
ascii_table=$(ascii -x -t | sed -E 's/( ){3,}/\n/g' | awk '$0 !~ "^$" { print $0 }')

string_to_encode=$1


grep -o . <<< "$string_to_encode" | while read letter; do
	printf "%%%s" "$(echo "$ascii_table" | grep "$letter" - | cut -d' ' -f1)"
done

printf "\n"
