#!/usr/bin/env sh

# xinput disable 'ETPS/2 Elantech Touchpad' &

echo 'Starting redshift'
redshift -c $HOME/.config/redshift.conf &
echo 'Starting dunst'
dunst &

xset r rate 300 40

echo 'Starting XMonad'
exec xmonad
