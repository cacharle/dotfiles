# xinput disable 'ETPS/2 Elantech Touchpad' &

echo 'Starting redshift'
redshift -c /home/charles/.config/redshift.conf &
echo 'Starting dunst'
dunst &
xset r rate 200 50
exec xmonad
