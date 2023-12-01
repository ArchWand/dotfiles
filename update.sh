#!/bin/zsh
# Make sure script is run from the directory it is in
cd "$(dirname "$0")"

function up_dir {
	rsync -a --delete $1 ./$2
}
function up_file {
	cp $1 ./$2
}

# Maintained directly in dotfiles repo:
# helper.rules for spotdl-helper
# ODroidXU4
# phone

fcrontab -l > crontab 2> /dev/null

up_dir ~/scripts
up_dir ~/.config/bspwm
up_dir ~/.config/espanso/match espanso
up_dir ~/.config/kitty
up_dir ~/.config/mpv
up_dir ~/.config/nvim
up_dir ~/.config/sxhkd
up_dir ~/.config/zathura
up_dir /etc/X11/xorg.conf.d

up_file ~/.bash_profile
up_file ~/.bashrc
up_file ~/.zprofile
up_file ~/.zshrc
up_file ~/.zshenv
up_file ~/.config/betterlockscreen/betterlockscreenrc
up_file ~/.config/libinput-gestures.conf
up_file ~/.config/dunst/dunstrc
up_file ~/.config/picom/picom.conf
up_file ~/.config/systemd/user/todo-sync.path systemd/
up_file ~/.config/systemd/user/todo-sync.service systemd/
up_file ~/.config/X11/xinitrc
up_file ~/.local/share/oh-my-zsh/custom/themes/arcwand.zsh-theme
up_file /etc/logid.cfg

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
