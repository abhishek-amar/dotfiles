#!/bin/bash

# Place in ~/.dwm as autostart.sh

# Restore wallpaper
nitrogen --restore &

# Start NetworkManager applet
nm-applet &

# Start XFCE power manager(for battery management and brightness adjustment)
xfce4-power-manager &

# Start compositor (for transparency, shadows and fade)
picom --config $HOME/.config/picom/picom.conf &

# Start music player daemon
mpd &

# Turn on numlock
numlockx on &

# dwm bar configuration

dte(){
    dte="$(date +"%a, %B %d,%l:%M%p")"
    echo -e "$dte"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "RAM: $mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

vol(){
    vol="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    echo -e "Vol: $vol"
}

while true; do
    xsetroot -name "$(cpu) | $(mem) | $(vol) | $(dte)"
     sleep 0.1
done &
