#
# ~/.bashrc
#

source ~/.zshenv

export HISTFILE="${XDG_STATE_HOME}"/bash/history

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

print_pre_prompt () {
	PS1L=$PWD
	if [[ $PS1L/ = "$HOME"/* ]]; then PS1L=\~${PS1L#$HOME}; fi
	PS1R=$USER@$HOSTNAME

	local dash_len=$(($COLUMNS- ${#PS1L} - 9 - ${#PS1R}))

	printf '\e[01;36m'"$PS1L    "
	if [ $dash_len -gt 1 ] ; then
		printf '\e[02;37m'
		printf -- '.%.0s' $(seq 1 $dash_len)
		printf '\e[0;32m'"    $PS1R"
	fi
}

PROMPT_COMMAND=print_pre_prompt
PS1='\[\e[00m\]\n$ '

export EDITOR='nvim'

# Add scripts directory to PATH
export PATH="$HOME/scripts/.path:$PATH"
# Add local bin to path
export PATH="$HOME/.local/bin:$PATH"
# Add cargo bins to path
export PATH="$HOME/.local/share/cargo/bin:$PATH"

function rmcd {
	dir="$(pwd)" && cd .. && rm "$dir" -rf || cd "$dir"
}
function rdcd {
	dir="$(pwd)" && cd .. && rd "$dir" || cd "$dir"
}
function mcd {
	mkdir -p "$1" && cd "$1"
}
function mvcwd {
	dir="$(pwd)" && cd .. && mv "$dir" "$1" ;
	cd "$1"
}
function superkill {
	while pkill -9 "$1" && killall "$1"; do :; done
}

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rc"
alias cdnew='cd "$(ls -rcd */ | tail -n 1)"'

alias icat="kitty +kitten icat"
alias ssh="kitty +kitten ssh"
alias nv=nvim
alias clip="xsel -b"
alias ranger=". ranger"
alias plover="~/Applications/plover-4.0.0.dev12-x86_64_1117a3034f0a02c8898a2bccdcb0a905.AppImage"
alias py=python

alias cmd='command'
alias hardclear='echo -ne "\ec"'
alias reset="tput reset"
alias kitty-disable-ime='unset GLFW_IM_MODULE && kitty'
alias init-nvm='source /usr/share/nvm/init-nvm.sh'
alias xev-keyboard='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'
alias startx11vnc="x11vnc -display :0 -usepw"


export QSYS_ROOTDIR="/home/arcwand/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/24.1/quartus/sopc_builder/bin"
