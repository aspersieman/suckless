#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill /home/nicol/src/opt/catppuccin-wallpapers/landscapes/tropic_island_night.jpg &
xset r rate 200 50 &
picom &

bash /home/nicol/src/opt/suckless/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
