#
# ~/.bashrc
#

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
export PATH="$HOME/.scripts:$PATH"
# Add local bin to path
export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"

function cdrm {
	dir="$(pwd)" &&\
		cd .. &&\
		rm "$dir" -rf
}

function mcd {
	mkdir -p "$1" &&\
		cd "$1"
}

function mvcwd {
	dir="$(pwd)" &&\
		cd .. &&\
		mv "$dir" "$1" &&\
		cd "$1"
}

alias icat="kitty +icat"

alias ranger=". ranger"
alias py=python
alias clip="xsel -b"
alias reload-bash="source ~/.bashrc"

alias latex_template="cp ~/.local/share/latex_template/* ."

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rc"

echo line

