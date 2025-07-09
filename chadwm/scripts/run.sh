#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill /home/nicol/src/opt/catppuccin-wallpapers/os/debian-black-4k.png &
xset r rate 200 50 &
xss-lock -- slock &
# https://github.com/pijulius/picom
picom &

bash /home/nicol/src/opt/suckless/chadwm/scripts/bar.sh &
blueman-applet &
nm-applet &
yodo.sh icon &
while type chadwm >/dev/null; do chadwm && continue || break; done
