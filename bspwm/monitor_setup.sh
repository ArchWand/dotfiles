# Lets us execute code whenever bspwm detects any changes to the monitors
bspc subscribe monitor | while read -r line; do
case $line in
	monitor_geometry*)
		case $(autorandr --current) in
			monitor) # Name of the two-screen config
				;;
			laptop) # Name of the one-screen config
				;;
			*)	;;
		esac
		;;
	*)	;;
esac
done

