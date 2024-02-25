#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	firefox|Chromium|Google-chrome)
		xdotool key ctrl+Page_Up
		;;
	discord|VencordDesktop|Slack)
		xdotool key alt+shift+Up
		;;
	*kitty)
		case "$name" in
			*)
				xdotool key ctrl+shift+Left
				;;
			nvim*|nv|lf|ranger)
				xdotool key ctrl+o
				;;
		esac
		;;
	thunderbird)
		xdotool key ctrl+shift+Tab
		;;
	jetbrains-studio)
		xdotool key g key T
		;;
	com.ra4king.circuitsim.gui.CircuitSim)
		xdotool key ctrl+shift+Tab
		;;
	"")
		bspc desktop -f prev.local --follow
		;;
	*)
		;;
esac
