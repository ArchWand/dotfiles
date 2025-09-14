# ArcWand's zshrc

# zmodload zsh/zprof

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.*.zsh.
if [[ $terminfo[colors] -ge 256 ]]; then
	p10k_file="/home/arcwand/.p10k.256.zsh"
else
	p10k_file="/home/arcwand/.p10k.8.zsh"
fi
[[ ! -f "$p10k_file" ]] || source "$p10k_file"
unset p10k_file

# Download Znap, if it's not there yet.
ZNAP_DIR="$HOME/.local/share/znap"
[[ -r $ZNAP_DIR/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZNAP_DIR/znap
source $ZNAP_DIR/znap/znap.zsh  # Start Znap

# Theme
# Powerlevel10k must use `source` and not `prompt`
znap source ArchWand/powerlevel10k

PS2='%B%F{8}%_%b>'"${PR_RST} "

# Plugins
znap source ajeetdsouza/zoxide
eval "$(zoxide init zsh --cmd cd)"

# znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-syntax-highlighting

# Borrow from Oh-my-zsh
znap source ohmyzsh/ohmyzsh \
  lib/clipboard.zsh \
  lib/completion.zsh \
  lib/directories.zsh \
  lib/functions.zsh \
  lib/grep.zsh \
  lib/history.zsh \
  lib/key-bindings.zsh \
  lib/spectrum.zsh \
  lib/theme-and-appearance.zsh \
  plugins/git \
  plugins/virtualenv

# set completion colors to be the same as `ls`, after theme has been loaded
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

##
# Set variables
#

# HISTSIZE
export HISTSIZE=50000
export SAVEHIST=50000

export EDITOR='nvim'

export PATH="$HOME/scripts/.path:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"
export PATH="$PATH:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl" # Add perl for biber

##
# Options
#

# Expand glob to empty string when no matches are found
setopt null_glob

##
# Shortcuts
#

# Make line into comment
bindkey '#' pound-insert
# By default, OMZ will `kill-whole-line`
bindkey '' backward-kill-line

##
# Completions
#

# Syncthing complections
complete -C /usr/bin/syncthing syncthing

##
# Functions and aliases
#

function rmcd { dir="$(pwd)" && cd .. && trash-put "$dir" || cd "$dir" }
function rdcd { dir="$(pwd)" && cd .. && rd "$dir" || cd "$dir" }
function mkcd { mkdir -p "$*" && cd "$*" }
function mvcwd { dir="$(pwd)" && cd .. && mv "$dir" "$1" || cd - ; cd "$1" }

function superkill { while pkill -9 "$1" && killall "$1"; do done }
function mpv_kill { sleep $1 && pkill -15 mpv && sleep 2 && kill -15 $(ps -o ppid= $$) }

function venv {
	if [ ! -d venv ]; then python3 -m venv venv; fi
	source venv/bin/activate
}
function open { open_command "${1:-.}" &> /dev/null & disown; }

function spectrum {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX" -p "/tmp")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rct"
alias cdnew='cd "$(ls -ctd */ | head -n 1)"'

autoload zcalc
alias icat="kitty +kitten icat"
alias hardclear='echo -ne "\ec"'
alias reset="tput reset"
alias init-nvm='source /usr/share/nvm/init-nvm.sh'
alias xev-keyboard='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'
alias startx11vnc="x11vnc -display :0 -usepw"
alias cdjournal="source ~/scripts/journal/cdjournal.sh"
alias cdj=cdjournal
alias dropcache="sync; echo 3 | sudo tee /proc/sys/vm/drop_caches"

alias rm=trash-put
alias nv=nvim
alias hx=helix
alias plover="~/Applications/plover-4.0.0.dev12-x86_64_1117a3034f0a02c8898a2bccdcb0a905.AppImage"
alias py='python3 -q'
# alias lf=". ranger"
alias rip=ripdrag
alias lg=lazygit
alias loc=scc
alias ghcp="gh copilot suggest"
alias vimgolf=/home/arcwand/.local/share/gem/ruby/3.4.0/bin/vimgolf

# ZSH Syntax Highlighting with Catpuccin theme (should be last)
source $ZNAP_DIR/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
