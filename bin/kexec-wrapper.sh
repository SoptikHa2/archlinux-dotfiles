#!/bin/sh
# This script restarts kernel. Useful if one needs to reboot but doesn't
# actually want to reboot as it takes up to 7 seconds.
# This script does the same in half the time.
# This needs to be run as root.

# Tell kexec what to boot
kexec -l /boot/vmlinuz-linux-zen --initrd=/boot/initramfs-linux.img --reuse-cmdline
# Execute kexec. This will restart everything, including kernel.
systemctl kexec
