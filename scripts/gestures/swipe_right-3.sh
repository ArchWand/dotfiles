#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	firefox|Chromium|Google-chrome)
		xdotool key ctrl+Page_Down
		;;
	discord|VencordDesktop|Slack)
		xdotool key alt+shift+Down
		;;
	*kitty)
		case "$name" in
			*)
				xdotool key ctrl+shift+Right
				;;
			nvim*|nv|lf|ranger)
				xdotool key ctrl+o
				;;
		esac
		;;
	thunderbird)
		xdotool key ctrl+Tab
		;;
	jetbrains-studio)
		xdotool key g key t
		;;
	com.ra4king.circuitsim.gui.CircuitSim)
		xdotool key ctrl+Tab
		;;
	"")
		bspc desktop -f next.local --follow
		;;
	*)
		;;
esac
