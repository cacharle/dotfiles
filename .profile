if [ -z $TMUX ]; then
    redshift -c $HOME/.dotfiles/redshift.conf &
fi

export PATH=$PATH:/usr/local/go/bin
