#! /bin/sh

xhost +local:$USER
Xephyr -ac -br -screen 1024x768 -dpi 90 :420
DISPLAY=":420"
./dwm 
