#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill /home/nicol/dotfiles/nice-blue-background.png &
xset r rate 200 50 &
picom &

dash /home/nicol/src/opt/suckless/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
