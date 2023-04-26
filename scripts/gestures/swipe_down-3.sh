#!/bin/zsh
export DISPLAY=:0
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Tab
		;;
	discord)
		xdotool key alt+shift+Down
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
			xdotool key ctrl+c
		else
		fi
		;;
	*)
		;;
esac

unset app
