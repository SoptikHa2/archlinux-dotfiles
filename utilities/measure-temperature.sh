#!/bin/zsh
set -euo pipefail

# This uses sensors(1)
echo $(/usr/bin/date +'%Y-%m-%d;%H-%M-%S'),$(/usr/bin/sensors | /usr/bin/grep '.*: *+[^(]*' -o | /usr/bin/sed -E 's/ *\+//;s/°.*//' | /usr/bin/sed -E ':s;N;s/\n/,/;t s') >> /home/petr/data/Documents/temperature.csv
