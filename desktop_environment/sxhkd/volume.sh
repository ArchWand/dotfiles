#!/bin/bash

# Priority of notification
PRIORITY=normal
# How long the notifications shows for in milliseconds
TIMEOUT=1000

# When changing the volume, round to the nearest multiple
# set to 1 to disable
round=5

send_notification() {
	notify-send -a "volume" \
		-u $PRIORITY -t $TIMEOUT -i "$3" \
		-h string:wired-tag:system-notif -h int:value:$2 \
		"Volume: $1"
}

vol() {
	amixer get Master | awk -F'[][[%]' '/%/{print $2}' | head -1
}

is_mute() {
	amixer get Master | grep '%' | awk '{print $6}' | grep off > /dev/null
}

volume_change() {
	# Automatically unmute upon volume adjustment
	if is_mute; then
		amixer set Master unmute
	fi

	volume=$(vol)
	# Change the volume appropriately
	# (rounding to the nearest multiple)
	if [[ $volume -eq $volume/${round}*${round} ]]; then
		volume=$(($volume + $1))
	else
		# Find nearest multiple of ${round}
		# volume=$((rounded volume + { $1 if $1 > 0, else 0 }))
		# Because we are rounding down
		volume=$(($volume/${round}*${round} + ($1>0)*$1))
	fi

	amixer set Master $volume%

	# Fetch the appropriate symbol for the new volume level
	volume=$(vol)
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
		if is_mute; then
			send_notification "Muted" 0 "audio-volume-muted-symbolic"
		else
			volume_change 0 args
			send_notification ${args[@]}
		fi
		;;
	up)
		volume_change $round args
		send_notification ${args[@]}
		;;
	down)
		volume_change -$round args
		send_notification ${args[@]}
		;;
	*)
		volume_change $1 args
		send_notification ${args[@]}
		;;
esac

