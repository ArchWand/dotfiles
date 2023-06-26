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
plugins=(git z)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

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
alias cdnew='cd "$(ls -rcd */ | tail -n 1)"'

function superkill {
	while pkill -9 "$1" && killall "$1"; do done
}

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rc"

alias cmd='command'
alias hardclear='echo -ne "\ec"'
alias reset="tput reset"

alias nv=nvim
alias clip="xsel -b"
alias ranger=". ranger"
alias plover="~/Applications/plover-4.0.0.dev12-x86_64_1117a3034f0a02c8898a2bccdcb0a905.AppImage"
alias py=python

alias icat="kitty +kitten icat"
alias ssh="kitty +kitten ssh"

alias zsh-no-git-prompt='git config --add oh-my-zsh.hide-status 1; git config --add oh-my-zsh.hide-dirty 1'
alias kitty-disable-ime='unset GLFW_IM_MODULE && kitty'
alias init-nvm='source /usr/share/nvm/init-nvm.sh'

alias startx11vnc="x11vnc -display :0 -usepw"

# ZSH Syntax Highlighting with Catpuccin theme
# source ~/.local/share/oh-my-zsh/custom/plugins/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
