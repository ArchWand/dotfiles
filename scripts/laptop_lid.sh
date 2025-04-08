#!/bin/bash

file="/etc/systemd/logind.conf"
param="HandleLidSwitch"
valid_values=(suspend ignore)

# if no parameters given, print current value
if [ -z "$1" ]; then
	value=$(grep -E "^\s*${param}\s*=" "$file" | sed "s/.*=\s*//")
	echo "Current value: ${value}"
	echo "Valid values: ${valid_values[@]}"
	exit 0
fi

value=$1
if [[ ! " ${valid_values[@]} " =~ " ${value} " ]]; then
	echo "Invalid value: ${value}"
	echo "Valid values: ${valid_values[@]}"
	exit 1
fi

sudo -v || exit

# Edit $param=$value
sudo sed -i -e 's/^#\?\('"$param"'=\)\(.*\)\(#.*\)\?$/\1'"$value"'/' "$file"

# Apply changes
sudo systemctl kill -s HUP systemd-logind

