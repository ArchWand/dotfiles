#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	discord|VencordDesktop)
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		xdotool key super+w
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
			xdotool key ctrl+d
		else
			xdotool key shift+z shift+z
		fi
		;;
	Spotify)
		bspc node -c
		;;
	thunderbird)
		xdotool key ctrl+w
		;;
	Zathura)
		xdotool key q
		;;
	jetbrains-studio)
		bspc node -c
		;;
	*)
		xdotool key ctrl+w
		;;
esac
