#!/bin/sh

for i in {1..106}; do
	# Prep time
	sleep 1.5

	# Switch focus to nvim
	xdotool key super+l

	# Search for the label
	xdotool key slash
	xdotool key ctrl+shift+s
	xdotool key Return

	# Inspection time
	sleep 1

	# Delete and save
	xdotool key d key d
	xdotool key ctrl+s

	# Switch focus to script and wait for select
	xdotool key super+h key super+j
	read
	xdotool key super+k
done 

