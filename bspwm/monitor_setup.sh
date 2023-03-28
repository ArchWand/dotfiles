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

		# Loop through all desktops on the external monitor
		for d in $(bspc query -D --names | grep "HDMI"); do
			# Move all nodes to the primary monitor
			bspc desktop -f "$d" &&\
				bspc node -f @/ &&\
				bspc node -d "eDP_$(echo "$d" | cut -d'_' -f 2)"
			# Deselect all nodes
			bspc node -f @first
		done

		# Finally, delete the unused monitor
		while bspc monitor -f "HDMI-1"; do
			bspc monitor -r
		done
		~/.config/bspwm/desktops.sh
		;;
	desk) # Name of the two-screen config
		added=1
		bspc monitor -f "HDMI-1" && added=0 ||\
			bspc wm --add-monitor "HDMI-1" 2560x1080+1920+0
		~/.config/bspwm/desktops.sh

		# Move all nodes to external monitor upon first connecting
		# but only if the monitor was not newly added
		[ $added -eq 1 ] &&\
		# Loop through all desktops on the primary monitor
		for d in $(bspc query -D --names | grep "eDP"); do
			# Move all nodes to the external monitor
			bspc desktop -f "$d" &&\
				bspc node -f @/ &&\
				bspc node -d "HDMI_$(echo "$d" | cut -d'_' -f 2)"
			# Deselect all nodes
			bspc node -f @first
		done
		;;
	monitor) # Name of the external monitor only config
		# Reset the names of the desktops
		# This is necessary since we will use a name based method to 
		# move all the windows
		~/.config/bspwm/desktops.sh

		# Loop through all desktops on the primary monitor
		for d in $(bspc query -D --names | grep "eDP"); do
			# Move all nodes to the external monitor
			bspc desktop -f "$d" &&\
				bspc node -f @/ &&\
				bspc node -d "HDMI_$(echo "$d" | cut -d'_' -f 2)"
			# Deselect all nodes
			bspc node -f @first
		done

		# Finally, delete the unused monitor
		while bspc monitor -f "eDP-1"; do
			bspc monitor -r
		done
		~/.config/bspwm/desktops.sh
		;;
	*)	;;
esac

# Just in case, adopt orphans
bspc wm -o
