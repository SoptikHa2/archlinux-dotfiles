#!/bin/bash
# Create new directory and launch vim in it. Once vim exits, remove the directory.
tempdir=$(mktemp -d) || exit 1

nvim "$tempdir/temptex.tex"

rm -rf "$tempdir"
