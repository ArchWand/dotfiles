# Always use detected autorandr config
autorandr --change
ar_conf=$(autorandr | grep detected | cut -d' ' -f 1 | head -n 1)
if [ -z "$ar_conf" ]; then
	ar_conf=$(autorandr --list | head -n 1)
fi

case $ar_conf in
	laptop) # Name of the one-screen config
		# Reset the names of the desktops
		# This is necessary since we will use a name based method to 
		# move all the windows
		~/.config/bspwm/desktops.sh

		start_desk="eDP_$(bspc query -D -d focused --names | cut -d'_' -f 2)"

		# Swap all desktops to the primary monitor
		for d in {01..10}; do
			bspc desktop HDMI_$d -s eDP_$d
		done
		~/.config/bspwm/desktops.sh

		# Finally, delete the unused monitor
		while bspc monitor -f "HDMI-1"; do
			bspc monitor -r
		done
		# And finish on the same desktop
		bspc desktop -f "$start_desk"
		;;
	desk) # Name of the two-screen config
		~/.config/bspwm/desktops.sh

		# Remember which desktop we started on
		start_desk=$(bspc query -D -d focused --names)

		# Add new monitor if it didn't already exist
		bspc monitor -f "HDMI-1" || bspc wm --add-monitor "HDMI-1" 2560x1080+1920+0

		# Move all nodes to external monitor
		# but only if there are no nodes already on the external monitor
		if [[ -z "$(bspc query -N -m "HDMI-1")" ]]; then
			# Update the start desktops
			start_desk="HDMI_$(echo "$start_desk" | cut -d'_' -f 2)"
			# Swap all desktops to the external monitor
			for d in {01..10}; do
				bspc desktop eDP_$d -s HDMI_$d
			done
			# Reset the desktop names
			~/.config/bspwm/desktops.sh
			# Set active for primary monitor
			bspc desktop -f "eDP_01"
		fi

		# Make sure to finish on the same desktop
		bspc desktop -f "$start_desk"
		;;
	monitor) # Name of the external monitor only config
		# Reset the names of the desktops
		# This is necessary since we will use a name based method to 
		# move all the windows
		~/.config/bspwm/desktops.sh

		# Remember which desktop we started on
		start_desk="HDMI_$(bspc query -D -d focused --names | cut -d'_' -f 2)"

		# Swap all desktops to the external monitor
		for d in {01..10}; do
			bspc desktop eDP_$d -s HDMI_$d
		done
		~/.config/bspwm/desktops.sh

		# Finally, delete the unused monitor
		while bspc monitor -f "eDP-1"; do
			bspc monitor -r
		done
		# And finish on the same desktop
		bspc desktop -f "$start_desk"
		;;
	*)	;;
esac

# Just in case, adopt orphans
bspc wm -o
