#!/bin/bash

xinput list | grep -Po 'id=\K\d+(?=.*slave\s*keyboard)' |\
	xargs -P0 -n1 xinput test | awk '/press/ {print $3}' |\
	while read -r key; do
		echo $key
		# case "$key" in
			# 66) notify-send Caps_Lock ;;
			# 77) notify-send Num_Lock ;;
			# 78) notify-send Scroll_Lock ;;
		# esac
	done
