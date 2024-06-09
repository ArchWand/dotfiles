#!/bin/bash

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000

# Adjust the brightness
xbacklight -$1 5 || exit
BRIGHTNESS=$(xbacklight -get)

# Send the notification, storing the ID
notify-send -a "brightness" \
	-u $PRIORITY -t $TIMEOUT -i display-brightness-symbolic \
	-h string:wired-tag:system-notif -h int:value:"${BRIGHTNESS}" \
	"Brightness: ${BRIGHTNESS}%"

