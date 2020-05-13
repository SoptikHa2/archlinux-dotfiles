# Setup

This contains script that one day should set up and provision functioning
archlinux install.

| Script name | Purpose |
| ----------- | ------- |
| [setup.sh](setup.sh) | Runs other script that setup particular part of system |
| [config-symlinks.sh](config-symlinks.sh) | Configures all the symlinks to `~/.config` and friends. This only sets up user application. This does NOT handle system things like X or network, but DOES handle window manager and friends. |
| [install-packages.sh](install-packages.sh) | Installs all the required packages from a file. TODO: Support `AUR`, `cargo install`. Possibly via yay or something? |
| [prepare-aur.sh](prepare-aur.sh) | Prepares AUR directory for my own AUR script and setups AUR symlinks. This creates aur directory in `~`, move it manually elsewhere if you wish to. |
| [setup-firefox.sh](setup-firefox.sh) | Spin up custom Firefox installation - `userChrome`, `userScript` and some configuration. Does *not* install addons - those sync over firefox account. |
