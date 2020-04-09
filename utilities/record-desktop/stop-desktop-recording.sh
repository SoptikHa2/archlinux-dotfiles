#!/bin/sh

# Find all recordmydesktop processes
# and send SIGINT singal to it

# From wiki:
# The SIGINT signal is sent to a process by its controlling terminal when a user wishes to interrupt the process. This is typically initiated by pressing Ctrl+C, but on some systems, the "delete" character or "break" key can be used.

killall -INT recordmydesktop

