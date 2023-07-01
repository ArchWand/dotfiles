#!/bin/bash
# full system backup

# Backup destination
backdest=/home/arcwand/backup

# Labels for backup name
#PC=${HOSTNAME}
pc=pavilion
distro=arch
type=full
date=$(date "+%F")
backupfile="$backdest/$distro-$type-$date.tar.gz"

# Exclude file location
prog=${0##*/} # Program name from filename
excdir="/home/arcwand/scripts"
exclude_file="$excdir/$prog-exc.txt"

# Check if chrooted prompt.
echo -n "First chroot from a LiveCD.  Are you ready to backup? (y/n): "
read executeback

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
  echo -n "No exclude file exists, continue? (y/n): "
  read continue
  if [ $continue == "n" ]; then exit; fi
fi

if [ $executeback = "y" ]; then
  # -p, --acls and --xattrs store all permissions, ACLs and extended attributes. 
  # Without both of these, many programs will stop working!
  # It is safe to remove the verbose (-v) flag. If you are using a 
  # slow terminal, this can greatly speed up the backup process.
  # Use bsdtar because GNU tar will not preserve extended attributes.
  bsdtar --exclude-from=$exclude_file --acls --xattrs -cpvzf $backupfile /
fi
