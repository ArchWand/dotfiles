#!/bin/sh
amixer set Master unmute

vfl=$(amixer get Master | grep "Front Left:" | awk -F'[][ %]' '{printf $8}')
vfr=$(amixer get Master | grep "Front Right:" | awk -F'[][ %]' '{printf $8}')
v=$(( ($vfl+$vfr)/2 ))

if [[ $v -eq $v/$1*$1 ]]; then
	v=$(($v + $1))
else
	v=$(($v/$1*$1 + ($1 + $1*($1<0?-1:1)) / 2))
fi

amixer set Master $v%
unset vfl vfr v
