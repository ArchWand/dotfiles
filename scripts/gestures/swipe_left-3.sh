#!/bin/zsh
export DISPLAY=:0
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Page_Up
		;;
	discord)
		xdotool key ctrl+shift+Tab
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
		else
			xdotool key Escape colon shift+n Return
		fi
		;;
	*)
		;;
esac

unset app
