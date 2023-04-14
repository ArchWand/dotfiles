#!/bin/sh
vfl=$(amixer get Master | grep "Front Left:" | awk -F'[][ %]' '{printf $8}')
vfr=$(amixer get Master | grep "Front Right:" | awk -F'[][ %]' '{printf $8}')

v=$((($vfl+$vfr)/2))
v=$(($v/5*5 + $1))

amixer set Master unmute
amixer set Master $v%

