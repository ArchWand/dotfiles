#!/bin/bash

# Most recent notification ID is stored within the script
ID=894
FILENAME=$0

set_id() {
	sed -i -E 's/^ID=[0-9]+/ID='$1'/' $FILENAME
}

get_id() {
	awk -F'=' '/^ID=/{print $2}' $FILENAME
}

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000

# Adjust the brightness
xbacklight -$1 5 || exit
BRIGHTNESS=$(xbacklight -get)

# Send the notification, storing the ID
(
flock -x -w 10 200 || exit 1

set_id $(notify-send -p -r $(get_id) -a "brightness" "Brightness: ${BRIGHTNESS}%" \
	-u $PRIORITY -t $TIMEOUT -h int:value:"${BRIGHTNESS}" \
	-i display-brightness-symbolic)

) 200>/tmp/.scripts.brightness.exclusivelock

