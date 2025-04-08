# zmodload zsh/zprof

# ArcWand's zshrc

# HISTSIZE
export HISTSIZE=50000
export SAVEHIST=50000

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/share/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="arcwand"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Allow loading from insecure directories
# ZSH_DISABLE_COMPFIX="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# Override Shortcuts
# By default, OMZ will `kill-whole-line`
bindkey '' backward-kill-line
# Make line into comment
bindkey '#' pound-insert

# Options
# Expand glob to empty string when no matches are found
setopt null_glob

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
export EDITOR='nvim'
# fi

# Add scripts directory to PATH
export PATH="$HOME/scripts/.path:$PATH"
# Add local bin to path
export PATH="$HOME/.local/bin:$PATH"
# Add cargo bins to path
export PATH="$HOME/.local/share/cargo/bin:$PATH"
# Add perl for biber
export PATH="$PATH:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

function rmcd { dir="$(pwd)" && cd .. && trash-put "$dir" || cd "$dir" }
function rdcd { dir="$(pwd)" && cd .. && rd "$dir" || cd "$dir" }
function mcd { mkdir -p "$*" && cd "$*" }
function mvcwd { dir="$(pwd)" && cd .. && mv "$dir" "$1" || cd - ; cd "$1" }

function superkill { while pkill -9 "$1" && killall "$1"; do done }
function mpv_kill { sleep $1 && pkill -15 mpv && sleep 2 && kill -15 $(ps -o ppid= $$) }

function venv {
	if [ ! -d venv ]; then python3 -m venv venv; fi
	source venv/bin/activate
}
function open { xdg-open "${1:-.}" &> /dev/null & disown; }

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rct"
alias cdnew='cd "$(ls -ctd */ | head -n 1)"'

alias icat="kitty +kitten icat"
alias clip="xsel -b"

autoload zcalc
alias hardclear='echo -ne "\ec"'
alias reset="tput reset"
alias zsh-no-git-prompt='git config --add oh-my-zsh.hide-status 1; git config --add oh-my-zsh.hide-dirty 1'
alias init-nvm='source /usr/share/nvm/init-nvm.sh'
alias xev-keyboard='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'
alias startx11vnc="x11vnc -display :0 -usepw"
alias cdjournal="source ~/scripts/journal/cdjournal.sh"
alias cdj=cdjournal

alias rm=trash-put
alias nv=nvim
alias plover="~/Applications/plover-4.0.0.dev12-x86_64_1117a3034f0a02c8898a2bccdcb0a905.AppImage"
alias py='python3 -q'
alias lf=". ranger"
alias rip=ripdrag
alias lg=lazygit
alias ghcp="gh copilot suggest"

# ZSH Syntax Highlighting with Catpuccin theme
# source ~/.local/share/oh-my-zsh/custom/plugins/themes/arcwand-zsh-syntax-highlighting.zsh
# source ~/.local/share/oh-my-zsh/custom/plugins/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

