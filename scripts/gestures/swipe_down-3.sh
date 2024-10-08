#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	firefox)
		xdotool key ctrl+r
		;;
	*kitty|*wezterm)
		case "$name" in
			*)
				xdotool key ctrl+c
				;;
		esac
		;;
	thunderbird)
		xdotool key n
		;;
	"")
		xdotool key super+q
		;;
	*)
		xdotool key Escape
		;;
esac
