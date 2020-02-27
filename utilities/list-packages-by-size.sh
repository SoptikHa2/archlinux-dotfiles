#!/bin/bash
pacman -Qei | grep -E '^(Name.*)|(Installed.*)$' | awk 'NR % 2 == 1 { name=$0 }NR % 2 == 0 { print name " " $0 }' | cut -d: -f2,3 | awk 'BEGIN{FS="Installed Size  :"}{print $1 "\t" $2}' | tr -d " " | sort -hk 2
