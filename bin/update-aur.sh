#!/bin/bash
for directory in */; do
	cd "$directory"
	echo 'Updating '$directory
	git pull
	makepkg -si --needed # -needed prevents pacman from reinstalling package useleslly
	cd ..
done
