# PS1='\[\e[1;32m\]\w \[\e[01;00m\]$ \e[00m\]'
# The termux prompt looks nice enough

export EDITOR='nvim'

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

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rc"
alias cdnew='cd "$(ls -rcd */ | tail -n 1)"'

alias py=python

alias cmd='command'
alias hardclear='echo -ne "\ec"'
alias laptop_ip='LAPTOP_IP=`ssh arcwand@128.61.104.106 "tail -n 1 laptop_ip.txt"` && echo $LAPTOP_IP'
alias startx11vnc='laptop_ip && ssh arcwand@$LAPTOP_IP "x11vnc -usepw -display :0"'

