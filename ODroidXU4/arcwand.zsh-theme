# arcwand.zsh-theme
# Custom theme

# Define colors
if [[ $terminfo[colors] -ge 256 ]]; then
	separator_c='%F{237}'
	current_path_c='%B%F{063}%K{238}'
	current_workdir_c='%B%F{167}%K{236}'
	gitpr_c='%B%F{063}%K{236}'
	shpm_c='%B%F{036}%K{236}'

	user_host_c='%F{241}'
else
	separator_c='%F{black}'
	current_path_c='%B%F{green}%K{grey}'
	current_workdir_c='%B%F{blue}%K{grey}'
	gitpr_c='%F{magenta}%K{grey}'
	shpm_c='%B%F{yellow}'

	user_host_c='%F{white}'
fi
return_code_c='%F{red}'
PR_RST='%b%f%k'


# ----- End Constants ----- #


# Helper variables
cpath='%~'
cwdir='%1~'

# separator dashes size function from aamnah
function term_width {
	[[ -n "${VIRTUAL_ENV-}" && -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" && "$PS1" = \(* ]] \
		&& echo $(( COLUMNS - ${#VIRTUAL_ENV} - 3 )) \
		|| echo $COLUMNS
}

function path_split {
	# The constant at the end of the math expression determines how much space is left
	local out=$(( COLUMNS - ${#VIRTUAL_ENV} - ${#cpath} - 25))
	[ "$out" -lt 0 ] && out=0
	echo $out
}

function get_user_host() {
	echo "$(git remote get-url origin 2>/dev/null || echo '%n@%m')"
}


# Define prompt strings
PROMPT_separator="${separator_c}"'${(l.$(dashed_line)..-.)}${PR_RST}'
PROMPT_current_path="${current_path_c}"'${${(%)cpath}%%${(%)cwdir}}${PR_RST}'
PROMPT_current_workdir="${current_workdir_c}"'%1~${PR_RST}'
PROMPT_gitpr="${gitpr_c}"'$(git_prompt_info)${PR_RST}'
PROMPT_shpm="${shpm_c}"'%($(path_split)l.'$'\n''.) %(!.#.»)'"${PR_RST}" # shell privilege marker


##### Prompt Formatting #####

preexec() {
	preexec_called=1
}

precmd() {
# Find prompt
	local ec=$?
	if [ "$ec" != 0 ] && [ "$preexec_called" = 1 ]; then
		local plain_bar1=" $ec ↵"
		local bar1=$(print -nP "${return_code_c}${plain_bar1}${PR_RST}")
		unset preexec_called
	fi
	local plain_bar2=" $(get_user_host)"
	local bar2=$(print -nP "${user_host_c}${plain_bar2}${PR_RST}")

	local len1=${#${(%%)plain_bar1}}
	local len2=${#${(%%)plain_bar2}}
	local dash_len=$(( $(term_width) - $len1 - $len2 - 1))

		print -nP "${separator_c}${(l.${dash_len}..-.)}${bar1}${bar2}${PR_RST}"
		print
}
# primary prompt: dashed separator, directory and vcs info
PROMPT="${PR_RST}${PROMPT_current_path}${PROMPT_current_workdir}${PROMPT_gitpr}${PROMPT_shpm}${PR_RST} "
PS2='%B%F{8}%_%b>${PR_RST} '

# right prompt: return code, virtualenv and context (user@host)
RPROMPT="${return_code}${user_host}${PR_RST}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="${gitpr_c}["
ZSH_THEME_GIT_PROMPT_SUFFIX="${gitpr_c}]"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
ZSH_GIT_PROMPT_SHOW_UPSTREAM=full

# Clear variables
unset current_path_c current_workdir_c gitpr_c shpm_c
unset gitpr_added gitpr_modified gitpr_deleted gitpr_renamed gitpr_unmerged gitpr_untracked
unset PR_RST

