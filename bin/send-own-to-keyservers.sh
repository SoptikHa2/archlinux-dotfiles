#!/bin/bash
# Send my own key to keyservers
for keyserver in "pgp.mit.edu" "keyserver.ubuntu.com" "keys.openpgp.org" "pool.sks-keyservers.net"; do
	gpg --keyserver "$keyserver" --send-keys "9DF928DF3EA2760421B1ED3C3BE4507F2C0C2FB6"
done
