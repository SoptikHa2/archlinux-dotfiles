sudo pacman -Syu $(grep '^[^#].*' "$1") --needed
