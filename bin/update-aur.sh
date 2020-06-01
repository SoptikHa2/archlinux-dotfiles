#!/bin/bash
# Arguments: ignored packages
for ignored in "$@"; do
	if [ -d "$ignored" ]; then
		echo "Package $ignored will not be updated."
	else
		echo "Package $ignored should be ignored, but doesn't exist."

	fi
done

for dir in *; do
	skip=0
	for ignored in "$@"; do
		if [[ $ignored == "$dir" ]]; then
			echo "Skipping $ignored."
			skip=1
			break
		fi
	done
	if [ -d "$dir" ] && [ $skip == 0 ]; then
		(
			cd "$dir" || return
			#clear
			echo "Updating $dir"
			# Force git pull (assumes master is the main branch)
			git fetch --all
            # Do not worry if we can't reset to master. It might
            # not exist.
			git reset --hard origin/master || true
			makepkg -si --needed # --needed tells pacman not to uselessly reinstall the package
		)
	fi
done

echo "All done."
