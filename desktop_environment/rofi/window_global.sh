#!/bin/bash

rofi -show window -monitor -1 -theme "~/.config/rofi/themes/catppuccin-mocha.rasi" -theme-str "$(cat ~/.config/rofi/themes/window_diff.rasi)" -kb-accept-entry '!Alt-Tab,!Alt-ISO_Left_Tab,!Alt-Alt_L,!Alt_L,!Alt-Alt_R,!Alt_R' -kb-row-down Alt-Tab -kb-row-up Alt-ISO_Left_Tab
