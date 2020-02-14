#!/bin/bash
for dir in *; do
	if [ -d "$dir" ]; then
		(
			cd "$dir" || return
			clear
			echo "Updating $dir"
			git pull
			makepkg -si --needed # --needed tells pacman not to uselessly reinstall the package
		)
	fi
done

clear
echo "All done."
