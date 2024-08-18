if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	export MOZ_USE_XINPUT2=1
	exec startx
fi
