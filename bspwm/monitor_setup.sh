# Always use detected autorandr config
autorandr --change
ar_conf=$(autorandr | grep detected | cut -d' ' -f 1 | head -n 1)
if [ -z "$ar_conf" ]; then
	ar_conf=$(autorandr --list | head -n 1)
fi

~/.config/bspwm/desktops.sh
case $ar_conf in
	laptop) # Name of the one-screen config
		start_desk="eDP_$(bspc query -D -d focused --names | cut -d'_' -f 2)"

		# Move all nodes to the primary monitor
		for d in {01..10}; do
			# Focus next desktop
			bspc desktop HDMI-1_$d -f &&\
			# Select all nodes
			bspc node -f @/ &&\
			# Move the nodes
			bspc node -d eDP-1_$d --follow &&\
			# Unselect the nodes
			bspc node -f @first
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
		# Remember which desktop we started on
		start_desk=$(bspc query -D -d focused --names)

		# Add new monitor if it didn't already exist
		bspc monitor -f "HDMI-1" || bspc wm --add-monitor "HDMI-1" 2560x1080+1920+0

		# Move all nodes to external monitor
		# but only if there are no nodes already on the external monitor
		if [[ -z "$(bspc query -N -m "HDMI-1")" ]]; then
			# Update the start desktops
			start_desk="HDMI-1_$(echo "$start_desk" | cut -d'_' -f 2)"
			# Swap all desktops to the external monitor
			for d in {01..10}; do
				bspc desktop eDP-1_$d -s HDMI-1_$d
			done
		fi
		# Reset the desktop names
		~/.config/bspwm/desktops.sh

		# Make sure to finish on the same desktop
		bspc desktop -f "$start_desk"
		;;
	monitor) # Name of the external monitor only config
		# Remember which desktop we started on
		start_desk="HDMI-1_$(bspc query -D -d focused --names | cut -d'_' -f 2)"

		# Move all nodes to the external monitor
		for d in {01..10}; do
			# Focus next desktop
			bspc desktop eDP-1_$d -f &&\
			# Select all nodes
			bspc node -f @/ &&\
			# Move the nodes
			bspc node -d HDMI-1_$d --follow &&\
			# Unselect the nodes
			bspc node -f @first
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
