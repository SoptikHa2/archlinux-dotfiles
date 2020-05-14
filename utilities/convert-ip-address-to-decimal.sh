#!/bin/sh
# Convert IPv4 address to decimal

ip_address="$1"
if [ -z "$1" ]; then
    echo "Synopsis: <IPv4 address> [number of overflows (default=0)]"
fi
overflows="0"
if [ -n "$2" ]; then
    overflows="$2"
fi

set -eu


# Workflow:
# INPUT:
# 81.2.197.14
# Then, convert each part to binary, so it looks like this:
# 01010001.00000010.11000101.00001110 (pad zeros!)
# Then, take it together and convert it to decimal:
# 01010001000000101100010100001110 ->
# 1359136014
# Then, if user wants to, overflow it. It's supposed to
# be implemented as a 32-bit integer, so
# simply adding 2**32 is enough.

# First step, convert to four binary octets, separated by newlines.
binary_separated_by_newlines=$(echo "$ip_address" | sed 's/\./\n/g' | xargs -n1 printf "ibase=10;obase=2;%s\n" | bc | xargs -n1 printf "%08d\n")

# Now, join the newlines together and convert it to decimal
decimal=$(echo "$binary_separated_by_newlines" | sed ':s;N;s/\n//;t s;p' | xargs -n1 printf "ibase=2;%s\n" | bc)

# Add overflow and print
echo "$decimal" | xargs -n1 printf "%s + (2^32)*$overflows\n" | bc

