echo "Install dependencies..."
sudo apt install libimlib2-dev picom feh acpi rofi xclip maim dash x11-xserver-utils light xbacklight blueman yad pasystray

echo " TODO: Set up Rofi from here https://github.com/adi1090x/rofi ..."

# Install https://elkowar.github.io/eww/

sudo tee /usr/share/xsessions/chadwm.desktop << EOL
[Desktop Entry]
Name=chadwm
Comment=dwm made beautiful
Exec=/home/nicol/src/opt/suckless/chadwm/scripts/./run.sh
Type=Application
EOL

sudo chmod 644 /usr/share/xsessions/chadwm.desktop

cd chadwm
rm -f config.h
sudo make clean install
cd -
