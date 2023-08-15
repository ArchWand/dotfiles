# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/arcwand/.local/share/oh-my-zsh/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="arcwand"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

source "$ZSH/oh-my-zsh.sh"


###### ENV VARS #####
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

###### ALIASES #####

function rmcd { dir="$(pwd)" && cd .. && rm "$dir" -rf || cd "$dir" }
function rdcd { dir="$(pwd)" && cd .. && rd "$dir" || cd "$dir" }
function mcd { mkdir -p "$1" && cd "$1" }
function mvcwd { dir="$(pwd)" && cd .. && mv "$dir" "$1" ; cd "$1" }
function superkill { while pkill -9 "$1" && killall "$1"; do done }

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'
alias la="ls -A"
alias ll="ls -lAh"
alias lc="ls -rc"
alias cdnew='cd "$(ls -rcd */ | tail -n 1)"'

alias nv=nvim
alias py=python

alias cmd='command'
alias hardclear='echo -ne "\ec"'
alias reset="tput reset"
# alias init-nvm='source /usr/share/nvm/init-nvm.sh'

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
