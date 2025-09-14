#!/bin/bash

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000

# When changing the volume, round to the nearest multiple
# set to 1 to disable
ROUND=5

# Get current volume level
get_volume() {
    amixer get Master | awk -F'[][[%]' '/%/{print $2}' | head -1
}

# Check if audio is muted
is_muted() {
    amixer get Master | grep '%' | awk '{print $6}' | grep off > /dev/null
}

send_notification() {
	notify-send -a "volume" \
		-u $PRIORITY -t $TIMEOUT -i "$3" \
		-h string:wired-tag:system-notif -h int:value:$2 \
		"Volume: $1"
}

volume_change() {
	local change=$1
	local volume=$(get_volume)

	# Automatically unmute upon volume adjustment
	if is_muted; then
		amixer set Master unmute
	fi

	volume=$(get_volume)
    # Check if volume is already at a multiple of ROUND
    if [[ $((volume % ROUND)) -eq 0 ]]; then
        volume=$((volume + change))
    else
        # Find nearest multiple of ROUND and add change if positive
        volume=$((volume / ROUND * ROUND + (change > 0 ? change : 0)))
    fi

	amixer set Master ${volume}%

	# Fetch the appropriate symbol for the new volume level
	volume=$(get_volume)
	local level
	if [[ $volume -le 33 ]]; then
		level="audio-volume-low-symbolic"
	elif [[ $volume -le 66 ]]; then
		level="audio-volume-medium-symbolic"
	elif [[ $volume -le 100 ]]; then
		level="audio-volume-high-symbolic"
	else
		level="audio-volume-overamplified-symbolic"
	fi

	args=("$volume%" $volume $level)
}

declare -a args
case $1 in
	mute)
		# toggle
		amixer set Master toggle
		if is_muted; then
			send_notification "Muted" 0 "audio-volume-muted-symbolic"
		else
			volume_change 0 args
			send_notification ${args[@]}
		fi
		;;
	up)
		volume_change $ROUND args
		send_notification ${args[@]}
		;;
	down)
		volume_change -$ROUND args
		send_notification ${args[@]}
		;;
	*)
		volume_change $1 args
		send_notification ${args[@]}
		;;
esac

