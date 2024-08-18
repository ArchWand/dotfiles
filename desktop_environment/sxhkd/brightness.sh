#!/bin/bash

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000
# What percentage the brightness should change by
PERCENTAGE=5
# How smoothly the brightness should transition
STEPS=1000

BRIGHTNESS=$(xbacklight -get)
case $1 in
	inc)
		BRIGHTNESS=$((BRIGHTNESS+PERCENTAGE))
		;;
	dec)
		BRIGHTNESS=$((BRIGHTNESS-PERCENTAGE))
		;;
esac

# Adjust the brightness
xbacklight -set $BRIGHTNESS || exit
BRIGHTNESS=$(xbacklight -get)

# Send the notification, storing the ID
notify-send -a "brightness" \
	-u $PRIORITY -t $TIMEOUT -i display-brightness-symbolic \
	-h string:wired-tag:system-notif -h int:value:"${BRIGHTNESS}" \
	"Brightness: ${BRIGHTNESS}%"
