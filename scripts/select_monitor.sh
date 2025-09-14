#!/bin/bash

# Script to determine which monitor contains the active window
# Dependencies: xdotool, xrandr, awk

# Get the position and size of the active window
window_info=$(xwininfo -id "$(xdotool getactivewindow)")
win_x=$(echo "$window_info" | grep "Absolute upper-left X" | awk '{print $4}')
win_y=$(echo "$window_info" | grep "Absolute upper-left Y" | awk '{print $4}')

# Get the center point of the window
win_width=$(echo "$window_info" | grep "Width" | awk '{print $2}')
win_height=$(echo "$window_info" | grep "Height" | awk '{print $2}')
center_x=$((win_x + win_width / 2))
center_y=$((win_y + win_height / 2))

# Get monitor information
monitors=$(xrandr --current | grep " connected")

# Find which monitor contains the window center
while read -r monitor_line; do
    monitor_name=$(echo "$monitor_line" | awk '{print $1}')
    geometry=$(echo "$monitor_line" | grep -oP '\d+x\d+\+\d+\+\d+')
    
    # Extract monitor coordinates
    mon_width=$(echo "$geometry" | grep -oP '\d+x' | tr -d 'x')
    mon_height=$(echo "$geometry" | grep -oP 'x\d+' | tr -d 'x')
    mon_x=$(echo "$geometry" | grep -oP '\+\d+\+' | tr -d '+')
    mon_y=$(echo "$geometry" | grep -oP '\+\d+$' | tr -d '+')
    
    # Check if the window center is within this monitor
    if [ $center_x -ge $mon_x ] && [ $center_x -lt $((mon_x + mon_width)) ] && \
       [ $center_y -ge $mon_y ] && [ $center_y -lt $((mon_y + mon_height)) ]; then
        echo "${mon_width}x${mon_height}+${mon_x}+${mon_y}"
        exit 0
    fi
done <<< "$monitors"

# Could not determine which monitor contains the active window.
exit 1
