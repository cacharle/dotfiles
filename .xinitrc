# xinput disable 'ETPS/2 Elantech Touchpad' &
echo 'Starting redshift'
redshift -c /home/charles/.config/redshift.conf &
echo 'Starting dunst'
dunst &
echo 'Starting XMonad'
exec xmonad 2>&1 > /dev/null
