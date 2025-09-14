#!/bin/bash

file="/etc/systemd/logind.conf"
valid_params=(PowerKey PowerKeyLongPress SuspendKey HibernateKey LidSwitch LidSwitchDocked LidSwitchExternalPower IdleAction)
valid_values=(ignore poweroff reboot halt suspend hibernate hybrid-sleep suspend-then-hibernate lock kexec)

# If wrong number of parameters given, print current file
if [[ $# -gt 2 ]]; then
	value=$(grep -E "^\s*${param}\s*=" "$file" | sed "s/.*=\s*//")
	cat "$file"
	echo
	echo "Valid values: ${valid_values[@]}"
	exit 0
fi

param=$1
if [[ ! " ${valid_params[@]} " =~ " ${param} " ]]; then
	echo "Invalid param: ${param}"
	echo "Valid params: ${valid_params[@]}"
	exit 1
fi
param="Handle$1"

value=$2
if [[ ! " ${valid_values[@]} " =~ " ${value} " ]]; then
	echo "Invalid value: ${value}"
	cur_val=$(grep -E "^\s*${param}\s*=" "$file" | sed "s/.*=\s*//")
	echo "Current value: ${cur_val}"
	echo "Valid values: ${valid_values[@]}"
	exit 1
fi

sudo -v || exit

# Edit $param=$value
sudo sed -i -e 's/^#\?\('"$param"'=\)\(.*\)\(#.*\)\?$/\1'"$value"'/' "$file"

# Apply changes
sudo systemctl kill -s HUP systemd-logind

