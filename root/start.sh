#!/bin/sh

echo "Updating Clock"
hwclock -s
echo "Starting Freeswitch Daemon"
/usr/bin/freeswitch -nf
