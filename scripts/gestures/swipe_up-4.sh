#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	firefox)
		bspc node -c
		;;
	*)
		bspc node -k
		;;
esac

