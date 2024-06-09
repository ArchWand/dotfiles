#!/bin/zsh
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')
name=$(xprop -id $(xdotool getactivewindow) WM_NAME | awk -F '"' '{print $2}')

case "$app" in
	discord|VencordDesktop)
		bspc node -c
		;;
	firefox|Chromium|Google-chrome)
		xdotool key ctrl+w
		;;
	*kitty|*wezterm)
		case "$name" in
			nvim*|nv*|"make edit"|lf|ranger)
				xdotool key Escape shift+z shift+z
				;;
			lazygit|less|man*|btop)
				xdotool key q
				;;
			*)
				# xdotool key ctrl+u key ctrl+d
				xdotool key ctrl+z key x
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

