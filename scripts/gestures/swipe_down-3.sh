#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Tab
		;;
	discord|VencordDesktop)
		xdotool key Escape
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
		else
		fi
		;;
	thunderbird)
		xdotool key n
		;;
	*)
		xdotool key alt+Tab
		;;
esac
