#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		xdotool key ctrl+Page_Up
		;;
	discord|VencordDesktop)
		xdotool key alt+shift+Up
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
		else
			xdotool key Escape key colon key N key Return
		fi
		;;
	thunderbird)
		xdotool key ctrl+shift+Tab
		;;
	"")
		bspc desktop -f prev.local --follow
		;;
	*)
		;;
esac
