#!/bin/bash

# How long the notifications shows for in milliseconds
timeout=1000

# Dunst priority of notification
priority=normal

# When changing the volume, round to the nearest multiple
# set to 1 to disable
round=5

# Progress bar color
prog_color="#8ba9ed"

# Dunst stack tag; enables replacing the notification
dunst_tag=status_update

# Global variable to reduce number of amixer calls
volume=0

function get_volume() {
	local vfl=$(amixer get Master | grep "Front Left:" | awk -F'[][ %]' '{printf $8}')
	local vfr=$(amixer get Master | grep "Front Right:" | awk -F'[][ %]' '{printf $8}')
	local vmono=$(amixer get Master | grep "Mono:" | awk -F'[][ %]' '{printf $7}')
	if [[ -n $vfl || -n $vfr ]]; then
		echo $(( ($vfl+$vfr)/2 ))
	else
		echo $vmono
	fi
}

function is_mute() {
	amixer get Master | grep '%' | awk '{print $6}' | grep off > /dev/null
}

function volume_change() {
	# Automatically unmute upon volume adjustment
	amixer set Master unmute

	volume=$(get_volume)

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
}

# Uses Dunst
function send_notification() {
	if [[ $1 == "mute" ]]; then
		dunstify -a "volume" -i audio-volume-muted-symbolic -u $priority -t $timeout -h string:x-dunst-stack-tag:"$dunst_tag" "Volume: Muted"
		return
	fi

	# set level to low, medium, high, or overamplified
	if [[ $volume -le 33 ]]; then
		level=low
	elif [[ $volume -le 66 ]]; then
		level=medium
	elif [[ $volume -le 100 ]]; then
		level=high
	else
		level=overamplified
	fi

	dunstify -a "volume" -i audio-volume-$level-symbolic -u $priority -t $timeout -h string:x-dunst-stack-tag:"$dunst_tag" -h int:value:"$volume" "Volume: ${volume}%" -h string:hlcolor:"$prog_color"
}

case $1 in
	mute)
		# toggle
		amixer set Master toggle
		if is_mute; then
			send_notification mute
		else
			volume=$(get_volume)
			send_notification
		fi
		;;
	up)
		volume_change 5
		send_notification
		;;
	down)
		volume_change -5
		send_notification
		;;
	*)
		volume_change $1
		send_notification
		;;
esac

