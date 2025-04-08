if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	export MOZ_USE_XINPUT2=1
	exec startx
fi

export QSYS_ROOTDIR="/home/arcwand/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/24.1/quartus/sopc_builder/bin"
