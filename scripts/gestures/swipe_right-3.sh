#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Page_Down
		;;
	discord|VencordDesktop)
		xdotool key alt+shift+Down
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
		else
		fi
		;;
	thunderbird)
		xdotool key ctrl+Tab
		;;
	"")
		xdotool key super+bracketright
		;;
	*)
		;;
esac
