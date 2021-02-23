#!/usr/bin/env sh

# xinput disable 'ETPS/2 Elantech Touchpad' &

echo 'Starting redshift'
redshift -c $HOME/.config/redshift.conf &
echo 'Starting dunst'
dunst &
xset r rate 200 50

[ "$(cat /etc/hostname)" = 'cacharle-main' ] &&
    xrandr --output DVI-0  --mode 1280x1024           --left-of DVI-1  \
           --output DVI-1  --mode 1920x1080 --primary --left-of HDMI-0 \
           --output HDMI-0 --mode 1920x1080

[ "$(cat /etc/hostname)" = 'charles-laptop' ] &&
    xrandr | grep 'VGA1.*connected' &&
    xrandr --output LVDS1 --primary --left-of VGA1 \
           --output VGA1 --mode 1280x1024

exec xmonad
