#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+r
		;;
	*kitty)
		xdotool key ctrl+c
		;;
	thunderbird)
		xdotool key n
		;;
	*)
		xdotool key Escape
		;;
esac
