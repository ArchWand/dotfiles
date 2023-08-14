#!/bin/zsh
# app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done

# case "$app" in
	# *)
		xdotool key super+bracketright
		# ;;
# esac

for id in $(xdotool search --class polybar); do $HOME/scripts/hideIt.sh --id $id --toggle-override; done
