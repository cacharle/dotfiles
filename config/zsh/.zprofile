#!/bin/sh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:$HOME/.local/bin"

# applications
export EDITOR='vim'
export TERM='st-256color'
export TERMINAL='st'
export MAIL='me@cacharle.xyz'
export BROWSER='qutebrowser'
export BROWSERCLI='w3m'

# XDG all the things
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIT="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$XDG_CACHE_HOME/histfile"

# color in man (less pager)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


export MINIKUBE_IN_STYLE=false  # disable cringe minikube emojies

# school env
export MINISHELL_TEST_BONUS=yes
export MINISHELL_TEST_PAGER=vim
export MINISHELL_TEST_FLAGS=-DMINISHELL_TEST
export WEBSERV_FLAGS=-DWEBSERV_CACHARLE

[ "$(tty)" = '/dev/tty1' ] && exec startx
