#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
WALLPAPER=$(find /home/nicol/Pictures/wallpaper/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) | shuf -n 1)
feh --bg-fill "${WALLPAPER}" &
xset r rate 200 50 &
xss-lock -- slock &
# https://github.com/pijulius/picom
picom &

bash /home/nicol/src/opt/suckless/chadwm/scripts/bar.sh &
blueman-applet &
pasystray &
nm-applet &
yodo.sh icon &
buttery.sh &
~/.dropbox-dist/dropboxd &
while type chadwm >/dev/null; do chadwm && continue || break; done
