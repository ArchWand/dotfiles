#!/bin/bash

for mac in $(bluetoothctl devices | awk '{print $2}'); do
	bluetoothctl disconnect $mac
	bluetooth_battery $mac
	bluetoothctl connect $mac
done
