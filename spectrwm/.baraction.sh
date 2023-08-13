#!/bin/bash
# Place this file in ~ as .baraction.sh

hdd() {
  hdd="$(df -h | awk 'NR==4{print $3}')"
  echo -e "HDD: $hdd"
}


mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "RAM: $mem"
}


cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}


vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "VOL: $vol"
}

dte(){
    dte="$(date +"%a %b %d %I:%M%p")"
    echo -e "$dte"
}

bat(){
    bat="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0| awk 'NR==21{print $2}')"
    echo -e "BAT: $bat"
}

SLEEP_SEC=1

while :; do
    
    # Without battery status
#    echo "| +@fg=1;$(cpu)+@fg=0; |+@fg=2; $(mem) +@fg=0;|+@fg=3; $(hdd) +@fg=0;|+@fg=4; $(vol) +@fg=0;|+@fg=5; $(dte) +@fg=0;|"
    
    # With battery status
    echo "| +@fg=1;$(cpu)+@fg=0; |+@fg=2; $(mem) +@fg=0;|+@fg=3; $(hdd) +@fg=0;|+@fg=4; $(vol) +@fg=0;|+@fg=0; $(bat) |+@fg=5; $(dte) +@fg=0;|"
	sleep $SLEEP_SEC
done

