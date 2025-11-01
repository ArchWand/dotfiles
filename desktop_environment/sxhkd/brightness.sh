#!/bin/bash

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000
# What percentage the brightness should change by, and nearest value to round to
ROUND=5
# How smoothly the brightness should transition
STEPS=1000

# Get current brightness
get_brightness() {
    xbacklight -get
}

# Change brightness and handle rounding
brightness_change() {
    local change=$1
    local brightness
    
    # Check if brightness is already at a multiple of ROUND
    brightness=$(get_brightness)
    if [[ $((brightness % ROUND)) -eq 0 ]]; then
		brightness=$((brightness + change))
    else
        # Find nearest multiple of ROUND and add change if positive
        brightness=$((brightness / ROUND * ROUND + (change > 0 ? change : 0)))
	fi
    
    # Adjust the brightness
    xbacklight -set $brightness || exit
    
    # Return the actual brightness after setting
    brightness=$(get_brightness)
    echo $brightness
}

case $1 in
    inc)
        BRIGHTNESS=$(brightness_change $ROUND)
        ;;
    dec)
        BRIGHTNESS=$(brightness_change -$ROUND)
        ;;
    *)
        # If no argument or unknown argument, just round current brightness
        BRIGHTNESS=$(brightness_change 0)
        ;;
esac

# Send the notification, storing the ID
notify-send -a "brightness" \
	-u $PRIORITY -t $TIMEOUT -i display-brightness-symbolic \
	-h string:wired-tag:system-notif -h int:value:"${BRIGHTNESS}" \
	"Brightness: ${BRIGHTNESS}%"
