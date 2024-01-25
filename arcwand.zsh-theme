# arcwand.zsh-theme
# Custom theme

# Catpuccin Colors
cat_mocha_rosewater=224
cat_mocha_flamingo=224
cat_mocha_pink=218
cat_mocha_mauve=183
cat_mocha_red=211
cat_mocha_maroon=181
cat_mocha_peach=216
cat_mocha_yellow=223
cat_mocha_green=151
cat_mocha_teal=116
cat_mocha_sky=116
cat_mocha_sapphire=117
cat_mocha_blue=111
cat_mocha_lavender=147
cat_mocha_text=189
cat_mocha_subtext1=146
cat_mocha_subtext0=146
cat_mocha_overlay2=103
cat_mocha_overlay1=103
cat_mocha_overlay0=243
cat_mocha_surface2=241
cat_mocha_surface1=239
cat_mocha_surface0=237
cat_mocha_base=235
cat_mocha_mantle=234
cat_mocha_crust=233


# Define colors
if [[ $terminfo[colors] -ge 256 ]]; then
	separator_c='%F{237}'
  exec_time_c='%F{241}'
  return_code_c='%F{red}'
	user_host_c='%F{241}'

	virtualenv_c='%B%F{197}%K{236}'
	current_path_c='%B%F{036}%K{238}'
	current_workdir_c='%B%F{063}%K{236}'
	gitpr_c='%B%F{137}%K{236}'
	shpm_c='%B%F{035}%K{236}'
else
	separator_c='%F{black}'
  exec_time_c='%F{grey}'
  return_code_c='%F{red}'
	user_host_c='%F{white}'

	virtualenv_c='%B%F{red}%K{grey}'
	current_path_c='%B%F{green}%K{grey}'
	current_workdir_c='%B%F{blue}%K{grey}'
	gitpr_c='%F{magenta}%K{grey}'
	shpm_c='%B%F{yellow}%K{grey}'
fi
PR_RST='%b%f%k'

unset cat_mocha_rosewater cat_mocha_flamingo cat_mocha_pink cat_mocha_mauve cat_mocha_red cat_mocha_maroon cat_mocha_peach cat_mocha_yellow cat_mocha_green cat_mocha_teal cat_mocha_sky cat_mocha_sapphire cat_mocha_blue cat_mocha_lavender cat_mocha_text cat_mocha_subtext1 cat_mocha_subtext0 cat_mocha_overlay2 cat_mocha_overlay1 cat_mocha_overlay0 cat_mocha_surface2 cat_mocha_surface1 cat_mocha_surface0 cat_mocha_base cat_mocha_mantle cat_mocha_crust

# ----- End Colors ----- #


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
PROMPT_current_path="${current_path_c}"'${${(%)cpath}%%${(%)cwdir}}'"${PR_RST}"
PROMPT_current_workdir="${current_workdir_c}"'%1~'"${PR_RST}"
PROMPT_gitpr="${gitpr_c}"'$(git_prompt_info)'"${PR_RST}"
PROMPT_virtualenv="${virtualenv_c}"'$(virtualenv_prompt_info)'"${PR_RST}"
PROMPT_shpm="${shpm_c}"'%($(path_split)l.'$'\n''.) %(!.#.»)'"${PR_RST}" # shell privilege marker


##### Prompt Formatting #####

preexec() {
  preexec_called=$(($(date +%s%0N)/1000000))
}

precmd() {
  # Store the error code so we can do other operations without losing it
  local ec=$?

  # If we have just run a command, then do the following:
  if [ "$preexec_called" ]; then
    # Find how long the command took
    local now=$(($(date +%s%0N)/1000000))
    time=$((now - preexec_called))
    # Only display the time if it took long enough
    if [ "$time" -gt 0 ]; then
      local plain_exec_time="${time} ms "
      local exec_time=$(print -nP "${exec_time_c}${plain_exec_time}${PR_RST}")
    fi

    # In the event that there was an error code, display it
    if [ "$ec" != 0 ]; then
      local plain_return_code=" $ec ↵"
      local return_code=$(print -nP "${return_code_c}${plain_return_code}${PR_RST}")
    fi
    unset preexec_called
  fi

  # Find the user and host
  local plain_user_host=" $(get_user_host)"
  local user_host=$(print -nP "${user_host_c}${plain_user_host}${PR_RST}")

  # Find the length of the dashed separator, minus the extra info text.
  local dash_len=$(( $(term_width) - 1))
  (( dash_len -= ${#${(%%)plain_exec_time}} ))
  (( dash_len -= ${#${(%%)plain_return_code}} ))
  (( dash_len -= ${#${(%%)plain_user_host}} ))

  # print -nP "${separator_c}${(l.${dash_len}..-.)}${return_code}${user_host}${PR_RST}"
  print -nP "${exec_time}${separator_c}${(l.${dash_len}..-.)}${return_code}${user_host}${PR_RST}"
  print
}

# primary prompt: dashed separator, directory and vcs info
PROMPT="${PR_RST}${PROMPT_current_path}${PROMPT_current_workdir}${PROMPT_gitpr}${PROMPT_virtualenv}${PROMPT_shpm}${PR_RST} "
PS2='%B%F{8}%_%b>'"${PR_RST} "

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
unset virtualenv_c current_path_c current_workdir_c gitpr_c shpm_c
unset gitpr_added gitpr_modified gitpr_deleted gitpr_renamed gitpr_unmerged gitpr_untracked
unset PR_RST

