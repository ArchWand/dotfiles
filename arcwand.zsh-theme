# arcwand.zsh-theme
# Custom theme

# Define colors
if [[ $terminfo[colors] -ge 256 ]]; then
	separator_c='%F{237}'
	current_path_c='%B%F{036}%K{238}'
	current_workdir_c='%B%F{063}%K{236}'
	gitpr_c='%B%F{137}%K{236}'
	shpm_c='%B%F{035}'

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


# separator dashes size function from aamnah
function dashed_line {
	[[ -n "${VIRTUAL_ENV-}" && -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" && "$PS1" = \(* ]] \
		&& echo $(( COLUMNS - ${#VIRTUAL_ENV} - 3 )) \
		|| echo $COLUMNS
}

# Helper variables
cpath='%~'
cwdir='%1~'


# Define prompt strings
separator="${separator_c}"'${(l.$(dashed_line)..-.)}${PR_RST}'
current_path="${current_path_c}"'${${(%)cpath}%%${(%)cwdir}}${PR_RST}'
current_workdir="${current_workdir_c}"'%1~${PR_RST}'
gitpr="${gitpr_c}"'$(git_prompt_info)${PR_RST}'
shpm="${shpm_c}"'%(40l.
.)%(!.#.»)${PR_RST}' # shell privilege marker

function get_user_host() {
	echo "$(git remote get-url origin 2>/dev/null || echo '%n@%m')"
}

user_host="${user_host_c}"'$(get_user_host)${PR_RST}'
return_code="${return_code_c}%(?..%? ↵ )${PR_RST}"



##### Prompt Formatting #####

# primary prompt: dashed separator, directory and vcs info
PROMPT="${separator}
${current_path}${current_workdir}${gitpr} ${shpm}${PR_RST} "
PS2='%B%F{8}%_%b>'"${PR_RST} "

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
unset separator_c current_path_c current_workdir_c gitpr_c shpm_c user_host_c return_code_c
unset gitpr_added gitpr_modified gitpr_deleted gitpr_renamed gitpr_unmerged gitpr_untracked
unset PR_RST
unset separator current_path current_workdir gitpr shpm user_host return_code git_upstream

