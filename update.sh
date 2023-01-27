# Update directories that cannot be hard linked
function up_dir {
	echo "Updating $1"
	rsync -a --delete $1 .
}

up_dir ~/.config/bspwm
up_dir ~/.config/sxhkd
up_dir ~/.scripts
rm -rf ./.scripts/.cd_bookmarks

if [ "$1" = "-d" ]; then
	git diff
	exit
fi

# If first parameter is empty, default message
git add .
if [ -z "$1" ]; then
	git commit -m "Update dotfiles"
else
	git commit -m "$1"
fi
git push
