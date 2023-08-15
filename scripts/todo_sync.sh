#!/bin/sh

USERNAME=arcwand
IP=128.61.104.106
LOCALFILE=$HOME/Desktop/todo.txt
CLOUDFILE=/home/$USERNAME/todo/todo.txt
TIMEOUT=15

rsync -au $LOCALFILE $USERNAME@$IP:"$CLOUDFILE" --timeout=$TIMEOUT
rsync -au $USERNAME@$IP:$CLOUDFILE $LOCALFILE --timeout=$TIMEOUT

