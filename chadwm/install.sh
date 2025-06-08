sudo tee /usr/share/xsessions/chadwm.desktop << EOL
[Desktop Entry]
Name=chadwm
Comment=dwm made beautiful
Exec=/home/nicol/src/suckless/chadwm/scripts/./run.sh
Type=Application
EOL

sudo chmod 644 /usr/share/xsessions/chadwm.desktop

cd chadwm
rm -f config.h
sudo make clean install
cd -
