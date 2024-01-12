#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	discord|VencordDesktop)
		bspc node -c
		;;
	firefox)
		xdotool key ctrl+w
		;;
	*kitty)
		case "$name" in
			nvim*|nv*|"make edit"|lf|ranger)
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
		bspc node -c
		;;
esac

