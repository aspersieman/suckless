#!/bin/bash

Xephyr -screen 1024x768 :80 &
sleep 1

export DISPLAY=:80
/home/nicol/src/opt/suckless/chadwm/scripts/./run.sh
killall Xephyr
