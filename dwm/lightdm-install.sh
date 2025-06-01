sudo tee /usr/share/xsessions/dwm.desktop << EOL
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=startdwm
Icon=dwm
Type=XSession
EOL

sudo chmod 644 /usr/share/xsessions/dwm.desktop

sudo mkdir -p /var/log/dwm
sudo cp startdwm /usr/local/bin/startdwm

sudo make clean install
