#!/usr/bin/zsh

local monitors=(`polybar --list-monitors | cut -d":" -f1`)
local pids=(`pidof polybar`)

local focused=`bspc query -M -m focused --names`
local ind=0
for i in {1..${#monitors}}; do
	if [[ "${monitors[i]}" == "${focused}" ]]; then
		ind=i;
		break
	fi
done

local poly_id="${pids[((${#monitors} + 1 - $ind))]}"
polybar-msg -p "$poly_id" cmd toggle

