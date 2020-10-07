###########
# .bashrc #
###########

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias v='vim'

# adding superuser bin to PATH
export PATH="/sbin:$PATH"

# man with color
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PS1="\n\[$(tput bold)$(tput setaf 2)\]\w\n\[$(tput setaf 1)\]❯ \[$(    tput sgr0)\]"

# set XDG paths
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_DATA_HOME="$HOME/.data/"

# vim key bindings
set -o vi

# Added by c_formatter_42
export PATH="$PATH:/Users/cacharle/git/c_formatter_42"
