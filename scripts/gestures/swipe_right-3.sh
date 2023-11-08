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
		xdotool key ctrl+shift+Right
		;;
	thunderbird)
		xdotool key ctrl+Tab
		;;
	"")
		bspc desktop -f next.local --follow
		;;
	*)
		;;
esac
