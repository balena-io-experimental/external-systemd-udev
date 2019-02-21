#!/bin/bash

echo "Starting up!"
sleep 2
while : ; do
	echo "Listing disk by label (plug in a new USB disk formatted with a label to see it show up)"
	ls -la /dev/disk/by-label/
	sleep 10
done
