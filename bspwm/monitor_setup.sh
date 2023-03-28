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

		# Then move all windows to the primary monitor
		for d in $(bspc query -D --names | grep "HDMI"); do
			bspc desktop -f "$d" &&\
				bspc node -f @/ &&\
				bspc node -d "eDP_$(echo "$d" | cut -d'_' -f 2)"
		done

		# Finally, delete the monitor
		while bspc monitor -f "HDMI-1"; do
			bspc monitor -r
		done
		~/.config/bspwm/desktops.sh
		bspc node -f @first
		;;
	desk) # Name of the two-screen config
		bspc monitor -f "HDMI-1" || bspc wm --add-monitor "HDMI-1" 2560x1080+1920+0
		~/.config/bspwm/desktops.sh

		# Move all nodes to external monitor upon first connecting
		# (personal preference) 
		for d in $(bspc query -D --names | grep "eDP"); do
			bspc desktop -f "$d" &&\
				bspc node -f @/
				bspc node -d "HDMI_$(echo "$d" | cut -d'_' -f 2)"
		done

		bspc node -f @first
		# End with focus on main monitor, first desktop
		bspc desktop -f eDP_01
		bspc desktop -f HDMI_01
		;;
	monitor) # Name of the external monitor only config
		# Reset the names of the desktops
		# This is necessary since we will use a name based method to 
		# move all the windows
		~/.config/bspwm/desktops.sh

		# Then move all windows to the external monitor
		for d in $(bspc query -D --names | grep "eDP"); do
			bspc desktop -f "$d" &&\
				bspc node -f @/ &&\
				bspc node -d "HDMI_$(echo "$d" | cut -d'_' -f 2)"
		done

		# Finally, delete the monitor
		while bspc monitor -f "eDP-1"; do
			bspc monitor -r
		done
		~/.config/bspwm/desktops.sh
		bspc node -f @first
		;;
	*)	;;
esac

# Just in case, adopt orphans
bspc wm -o
