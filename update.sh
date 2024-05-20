#!/bin/zsh
# Make sure script is run from the directory it is in
cd "$(dirname "$0")"

function up_dir {
	rsync -a --delete "$1" ./"$2"
}
function up_file {
	cp "$1" ./"$2"
}

# Maintained directly in dotfiles repo:
# helper.rules for spotdl-helper
# ODroidXU4
# phone

up_dir ~/.config/bspwm desktop_environment
up_dir ~/.config/polybar desktop_environment
up_dir ~/.config/rofi desktop_environment
up_dir ~/.config/sxhkd desktop_environment
up_dir /etc/X11/xorg.conf.d desktop_environment
up_file ~/.config/betterlockscreen/betterlockscreenrc desktop_environment
up_file ~/.config/dunst/dunstrc desktop_environment
up_file ~/.config/libinput-gestures.conf desktop_environment
up_file /etc/logid.cfg desktop_environment
up_file ~/.config/picom/picom.conf desktop_environment
up_file ~/.config/X11/xinitrc desktop_environment

up_dir ~/scripts

up_dir ~/.config/kitty tools
up_dir ~/.config/mpv tools
up_dir ~/.config/nvim tools
up_dir ~/.config/zathura tools
up_file ~/.config/Vencord/settings/quickCss.css tools
fcrontab -l > tools/crontab 2> /dev/null
up_file ~/.bash_profile tools/shell/.bash_profile
up_file ~/.bashrc tools/shell/.bashrc
up_file ~/.zprofile tools/shell/.zprofile
up_file ~/.zshrc tools/shell/.zshrc
up_file ~/.zshenv tools/shell/.zshenv
up_file ~/.local/share/oh-my-zsh/custom/themes/arcwand.zsh-theme tools/shell/arcwand.zsh-theme

# If the script is called without parameters,
# allow for manual committing
if [[ -z "$1" ]]; then
	exit
fi

# Check diffs
if [[ "$1" = "-d" ]]; then
	git diff
	exit
fi

# Auto-commit everything
if [[ -a "$1" ]]; then
	git add .
	if [[ -z "$2" ]]; then
		git commit -m "Update dotfiles"
	else
		git commit -m "$2"
	fi
	git push
fi
