#!/bin/sh

rsync -au $HOME/Desktop/todo.txt arcwand@128.113.148.173:/home/arcwand/todo/todo.txt --timeout=15
rsync -au arcwand@128.113.148.173:/home/arcwand/todo/todo.txt $HOME/Desktop/todo.txt --timeout=15

