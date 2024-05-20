#!/bin/bash

# How long the notifications shows for in milliseconds
timeout=1000

# Dunst priority of notification
priority=normal

# Progress bar color
prog_color="#8ba9ed"

# Dunst stack tag; enables replacing the notification
dunst_tag=status_update

# Uses Dunst
function send_notification() {
	sleep 0.05
	brightness=$(echo "100*$(cat /sys/class/backlight/intel_backlight/brightness)/$(cat /sys/class/backlight/intel_backlight/max_brightness)" | bc)
	dunstify -a "brightness" -i display-brightness-symbolic -u $priority -t $timeout -h string:x-dunst-stack-tag:"$dunst_tag" -h int:value:"${brightness}" "Brightness: ${brightness}%" -h string:hlcolor:"$prog_color"
}

case $1 in
	inc)
		xbacklight -inc 5
		send_notification
		;;
	dec)
		xbacklight -dec 5
		send_notification
		;;
esac

