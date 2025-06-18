#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

MODE=$1
interval=0

# load colors
. ~/src/opt/suckless/chadwm/scripts/bar_themes/catppuccin

cpu() {
    #cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
    cpu_val=$(cat /proc/stat | grep cpu |tail -1|awk '{print ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)}'|awk '{print 100-$1}')
    cpu_val=$(printf "%.0f" $cpu_val)

    # Use different colour for cpu_val. 0-20 green; 21-70 white; over 70 red
    color=$green
    if [ $cpu_val -gt 20 ]; then
        color=$white
    fi
    if [ $cpu_val -gt 70 ]; then
        color=$red
    fi

    printf "^c$green^ ^b$black^  "
    printf "^c$color^ ^b$grey^ $cpu_val%%"
}

pkg_updates() {
    #updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
    # updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
    updates=$({ timeout 20 apt list --upgradable 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)
    if [ "$updates" -eq "1" ]; then
        updates=0
    fi

    if [ -z "$updates" ] || [ "$updates" -eq "0" ]; then
        printf "  ^c$red^    Fully Updated"
    else
        printf "  ^c$red^    $(($updates - 1))"" updates"
    fi
}

brightness() {
    printf "^c$red^   "
    printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

disk() {
    disk_val=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}' | sed 's/%//')
    disk_val=$(printf "%.0f" $disk_val)
    printf "^c$green^^b$black^  "
    printf "^c$green^ $disk_val%%"
}

mem() {
    mem_val=$(free -m | awk 'NR==2{printf "%.0f\t\t", $3*100/$2 }')
    mem_val=$(printf "%.0f" $mem_val)
    printf "^c$green^^b$black^  "
    printf "^c$green^ $mem_val%%"
}

wlan() {
    # Set the name of the wifi network currently connected
    WIFI=$(nmcli -t -f active,ssid dev wifi | egrep 'yes' | sed 's/yes://') 
    case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
        up) printf "^c$black^ ^b$darkblue^ 󰤨 "; printf "^c$black^^b$blue^ ${WIFI}" ;;
        down) printf "^c$black^ ^b$darkblue^ 󰤭  "; printf "^c$black^^b$blue^ Disconnected" ;;
    esac
}

vpn() {
    vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1 | cut -d ':' -f 1)"

    case "$1" in
        --disconnect)
            nmcli con down $vpn
            ;;
        *)
            if [ -n "$vpn" ]; then
                    printf " $vpn"
            fi
            ;;
    esac
}

volume() {
    volume="$(pactl list sinks | grep -A 7 "$(pactl info | grep 'Default Sink' | cut -d' ' -f 3)" | grep Volume | awk '{print $5}')"
    mute="$(pactl list sinks | grep -A 7 "$(pactl info | grep 'Default Sink' | cut -d' ' -f 3)" | grep Mute | awk '{print $2}')"
    if [[ "$volume" == 0 || "$mute" == "yes" ]]; then
        printf "^c$black^ ^b$darkblue^ 󰖁 "
    else
        printf "^c$black^ ^b$darkblue^ 󰕾 "
        printf "^c$black^^b$blue^ ${volume}%"
    fi
}

battery() {
    get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
    # Use different icon depending on battery percentage
    battery_icon="󰁹"
    if [ $get_capacity -gt 0 ]; then
        battery_icon="󰂃"
    fi
    if [ $get_capacity -gt 10 ]; then
        battery_icon="󰁺"
    fi
    if [ $get_capacity -gt 20 ]; then
        battery_icon="󰁻"
    fi
    if [ $get_capacity -gt 30 ]; then
        battery_icon="󰁼"
    fi
    if [ $get_capacity -gt 40 ]; then
        battery_icon="󰁽"
    fi
    if [ $get_capacity -gt 50 ]; then
        battery_icon="󰁾"
    fi
    if [ $get_capacity -gt 60 ]; then
        battery_icon="󰁿"
    fi
    if [ $get_capacity -gt 70 ]; then
        battery_icon="󰂀"
    fi
    if [ $get_capacity -gt 80 ]; then
        battery_icon="󰂁"
    fi
    if [ $get_capacity -gt 90 ]; then
        battery_icon="󰂂"
    fi
    if [ $get_capacity -gt 10 ]; then
        printf "^c$black^ ^b$darkblue^ $battery_icon"
        printf "^c$black^^b$blue^ $get_capacity%%"
    fi
    if [ $get_capacity -lt 10 ]; then
        printf "^c$black^ ^b$darkblue^ $battery_icon"
        printf "^c$red^^b$blue^ $get_capacity%%"
    fi
}

clock() {
    printf "^c$black^ ^b$darkblue^ 󱑆 "
    printf "^c$black^^b$blue^ $(date '+%Y-%m-%d %H:%M:%S')  "
}

if [ "$MODE" = "debug" ]; then
    printf "$(pkg_updates)"
    exit 0
fi
while true; do
    [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
    interval=$((interval + 1))

    sleep 1 && xsetroot -name "$updates $(disk) $(cpu) $(mem) $(wlan)$(vpn) $(volume) $(battery) $(clock)"
done
