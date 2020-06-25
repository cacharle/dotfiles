if [[ "$(tty)" = "/dev/tty1" ]]; then
    startx
    # xset r rate 200 40
    poweroff
fi
