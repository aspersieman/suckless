#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill /home/nicol/src/opt/catppuccin-wallpapers/landscapes/tropic_island_night.jpg &
xset r rate 200 50 &
xss-lock -- slock &
picom &

bash /home/nicol/src/opt/suckless/chadwm/scripts/bar.sh &
blueman-manager &
yodo.sh icon &
while type chadwm >/dev/null; do chadwm && continue || break; done
