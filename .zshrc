export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="pure"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS=true
HIST_STAMPS="dd/mm/yyyy"

plugins=(colorize command-not-found git)
source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1
bindkey -v

setopt auto_cd
setopt pushd_ignore_dups
setopt list_rows_first

# alias expansion
bindkey "^ " _expand_alias # ctrl+space to expand
bindkey " " magic-space # space to avoid expansion
bindkey -M isearch " " magic-space

# alt-arrow to go forward/backward a word
# bindkey "^[[C" forward-word
# bindkey "^[[D" backward-word

alias -g G='| grep'
alias -g L='| less'
alias -g LO='192.168.0.'
alias rr='rm -r'
alias ll="ls -lFh"
alias la="ls -a"
alias lA="ls -al"
alias lss="ls -Ssh"
alias less="less -N"
alias mkdir="mkdir -p"
alias tree="tree -I '__pycache__'"
alias v="vim"
alias :q="exit"
alias :sp="tmux split-window"
alias :vsp="tmux split-window -h"
alias nmaplan="sudo nmap -sP '192.168.0.*'"
alias gdb="gdb -q"
alias node="nodejs"
alias python="python3.7"
alias info="info --vi-keys"
alias moula="gcc -Wall -Wextra -Werror"
alias list-c-includes-paths="echo | gcc -E -Wp,-v -"
alias yoump3='youtube-dl --extract-audio --audio-format mp3'

function chpwd() {
    file_count=$(ls | wc -w)
    if [ $file_count -lt 30 ]; then
        ls
    else
        echo "$(pwd) contains $file_count files"
    fi
}

export DOTFILES=$HOME/dotfiles
alias zshrc="vim $DOTFILES/.zshrc && source $DOTFILES/.zshrc"
alias vimrc="vim $DOTFILES/.vimrc"
alias vimplugrc="vim $DOTFILES/.vimrc -c 'vsp $DOTFILES/.pluggins.vim'"
alias tmuxrc="vim $DOTFILES/.tmux.conf && tmux source-file $DOTFILES/.tmux.conf"

# add command-not-found package suggestion
source /etc/zsh_command_not_found

# add /sbin to $PATH
export PATH="/sbin:/usr/local/sbin:/usr/sbin:$PATH"
# add my bin
export PATH="$HOME/bin:$PATH"

# man with color
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# XDG stuff
export XDG_CONFIG_HOME="/home/charles/.config/"
export XDG_DATA_HOME="/home/charles/.data/"

export EDITOR="vim"
