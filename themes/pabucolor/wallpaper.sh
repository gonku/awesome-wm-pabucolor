#!/bin/sh
while true; do
	find ~/.config/awesome/themes/pabucolor/wallpaper -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
		shuf -n1 -z | xargs -0 feh -F --bg-scale #--bg-max
	sleep 5m
done
