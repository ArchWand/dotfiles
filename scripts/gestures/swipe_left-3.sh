#!/bin/zsh
export DISPLAY=:0
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Page_Up
		;;
	discord)
		xdotool key alt+shift+Up
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
		else
		fi
		;;
	thunderbird)
		xdotool key ctrl+Page_Up
		;;
	*)
		;;
esac
