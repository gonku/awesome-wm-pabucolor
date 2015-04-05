#!/bin/bash

shopt -s nullglob
cd ~/.config/awesome/themes/pabucolor/wallpaper

while true; do
	files=()
	for i in *.jpg *.png; do
		[[ -f $i ]] && files+=("$i")
	done
	range=${#files[@]}

	((range)) && feh -F --bg-scale "${files[RANDOM % range]}"

	sleep  5m
done