#! /bin/bash

sudo apt install libgtk-3-dev libgcr-3-dev libwebkit2gtk-4.1-dev
rm -f config.h
sudo make clean install
