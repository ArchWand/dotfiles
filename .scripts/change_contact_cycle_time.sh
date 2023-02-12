#!/bin/sh

# Prep time
sleep 3

for i in {1..42}; do
	xdotool key d
	sleep 0.2 # wait for popup

	xdotool key Tab
	sleep 0.1
	xdotool key 4
	sleep 0.1
	xdotool key Return

	# Inspection time
	sleep 1

	xdotool key j
	sleep 0.2 # wait for card loading
done 

xdotool key Escape

