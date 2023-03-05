#!/bin/sh

rsync -au $HOME/Desktop/todo.txt arcwand@128.113.148.164:/home/arcwand/drive/todo.txt --timeout=15
rsync -au arcwand@128.113.148.164:/home/arcwand/drive/todo.txt $HOME/Desktop/todo.txt --timeout=15

