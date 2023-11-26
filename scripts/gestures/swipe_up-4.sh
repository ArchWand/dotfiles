#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	discord)
		bspc node -k
		;;
	*)
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		xdotool key super+w
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		;;
esac

