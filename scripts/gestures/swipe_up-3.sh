#!/bin/zsh
export DISPLAY=:0
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	Blueman-manager)
		xdotool key ctrl+w
		;;
	firefox)
		xdotool key ctrl+w
		;;
	discord)
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
			xdotool key ctrl+d
		else
			xdotool key shift+z shift+z
		fi
		;;
	thunderbird)
		xdotool key ctrl+w
		;;
	*)
		;;
esac

unset app
