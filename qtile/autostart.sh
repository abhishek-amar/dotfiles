#!/bin/bash

# Restore wallpaper
nitrogen --restore &

# Start NetworkManager applet
nm-applet &

# Start XFCE power manager(for battery management and brightness adjustment)
xfce4-power-manager &

# Start compositor (for transparency, shadows and fade)
picom --config $HOME/.config/picom/picom.conf &
