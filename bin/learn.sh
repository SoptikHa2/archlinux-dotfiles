#!/bin/sh
sudo chmod -x "$(whereis discord | cut -d' ' -f2)"
sudo chmod -x "$(whereis caprine | cut -d' ' -f2)"
killall Discord
killall caprine
