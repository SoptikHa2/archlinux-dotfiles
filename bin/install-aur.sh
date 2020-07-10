#!/bin/bash

set -eo pipefail

if [[ -z "$1"  ]]; then
    echo "Error: specify what to install" >&2
    exit 1
fi
if [[ -e "$1" ]]; then
    echo "Warn: $1 already exists." >&2
else
    git clone "https://aur.archlinux.org/$1.git" "$1"
fi

cd "$1"
git pull --force
bat -- *
echo "Install? [y/N]"
read -r install
if [[ "$install" == "y" ]]; then
    makepkg -si
else
    cd ..
    rm -rf "$1"
fi


