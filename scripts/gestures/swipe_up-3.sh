#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	discord|VencordDesktop)
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		xdotool key super+w
		for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
		;;
	*kitty)
		case "$name" in
			nvim*|lf|ranger)
				xdotool key shift+z shift+z
				;;
			lazygit)
				xdotool key q
				;;
			*less)
				xdotool key q
				;;
			man*)
				xdotool key q
				;;
			*)
				xdotool key ctrl+u key ctrl+d
				;;
		esac
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
		xdotool key shift+z shift+z
		;;
	*)
		xdotool key ctrl+w
		;;
esac
