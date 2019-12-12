#!/bin/bash
# Create new directory and launch vim in it. Once vim exits, remove the directory.
tempdir=$(mktemp -d) || exit 1

vim "$tempdir/temptex.tex"

rm -rf "$tempdir"
