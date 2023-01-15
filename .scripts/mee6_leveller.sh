#!/bin/bash

for i in {207..6000}; do
	sleep 50
	echo "$i" | xsel -b
	xdotool key Ctrl+v key Enter
done
