#!/bin/bash

# Returns internet status
# Options:
#	--numbers		Returns numbers instead of unicode symbols.
#	--unicode (default)	Return unicode symbols
#
# Numbers:
# 0 => connected
# 1 => connected, no internet
# 2 => not connected
#
#
# Unicode symbols:
# <todo>
#
# 
# Return code:
# <see numbers>

if [ ! -e $1 ]; then # if $1 is set
	if [ $1 = "--numbers" ]; then
		print_option=0
	elif [ $1 = "--unicode" ]; then
		print_option=1
	else
		(>&2 echo "Unknown option: $1")
		exit 1
	fi
else
	print_option=0
fi



# Check netctl for active connections
active_connection_count=$(netctl list | grep '*' -c)

# Try to ping mozilla, with 1 second deadline
if (ping mozilla.org -w 1 >/dev/null); then
	ping_succ=1
else
	ping_succ=0
fi

# And get code corresponding to data we gathered
return_code=2
if [ $active_connection_count -ge 1 ]; then
	return_code=1
	if [ $ping_succ -eq 1 ]; then
		return_code=0
	fi
fi

if [ $print_option -eq 0 ]; then
	echo $return_code
elif [ $print_option -eq 1 ]; then
	if [ $return_code -eq 0 ]; then
		echo ""
	elif [ $return_code -eq 1 ]; then
		echo "?"
	elif [ $return_code -eq 2 ]; then
		echo ""
	fi
else
	(>&2 echo "Unknown print option $print_option")
fi

exit $return_code
