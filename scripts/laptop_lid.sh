#!/bin/bash

file="/etc/systemd/logind.conf"
param="HandleLidSwitch"
value=$1

valid_values=(suspend ignore)
if [[ ! " ${valid_values[@]} " =~ " ${value} " ]]; then
	echo "Invalid value: ${value}"
	echo "Valid values: ${valid_values[@]}"
	exit 1
fi

sudo -v

# Edit $param=$value
sudo sed -i -e 's/^#\?\('"$param"'=\)\(.*\)\(#.*\)\?$/\1'"$value"' # Edited by laptop_lid.sh/' "$file"

# Apply changes
sudo systemctl kill -s HUP systemd-logind

