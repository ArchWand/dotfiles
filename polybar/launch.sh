#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar

# Launch the bar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
done
