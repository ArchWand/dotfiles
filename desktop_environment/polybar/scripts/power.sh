upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep energy-rate | awk '{printf "%2.2f W", $2}'
