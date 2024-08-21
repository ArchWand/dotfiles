#!/bin/zsh

dir="$HOME/Journal/$(date +%Y/%m/%d)"
mkdir -p "$dir" && \
cd "$dir" && \
printf "**$(date +"%H:%m")**  \\n\\n" >> page.md && nvim page.md -c 'normal! Gko'
