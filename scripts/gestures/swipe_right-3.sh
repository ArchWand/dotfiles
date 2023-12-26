#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	firefox)
		xdotool key ctrl+Page_Down
		;;
	discord|VencordDesktop|Slack)
		xdotool key alt+shift+Down
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
		xdotool key ctrl+Tab
		;;
	jetbrains-studio)
		xdotool key g key t
		;;
	"")
		bspc desktop -f next.local --follow
		;;
	*)
		;;
esac
