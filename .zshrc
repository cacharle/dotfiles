###############
# zshrc       #
###############

# load aliases
source $DOTFILES/.zsh_aliases

# pure prompt
export FPATH="$FPATH:$HOME/.zsh/pure"
ZSH_THEME="pure"
autoload -U promptinit
promptinit
prompt pure

# auto complete
autoload -U compinit
zstyle ':completion:*' matcher-list '' \
    'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=*' 'r:|=* l:|=* r:|=*'  # case insensitive
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vim keybindings in tab completion menu (https://www.youtube.com/watch?v=eLEo4OQ-cuQ)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vim keybindings in prompt
bindkey -v
export KEYTIMEOUT=1

setopt auto_cd  # cd without `cd` command
# setopt pushd_ignore_dups
# setopt list_rows_first
# setopt extendedglob

# executed when changind directory
function chpwd() {
    file_count=$(ls | wc -w)
    if [ $file_count -lt 30 ]; then
		tree -L 1
    else
        echo "$(pwd) contains $file_count files"
    fi
}

export DOTFILES=$HOME/dotfiles

# add command-not-found package suggestion
#source /etc/zsh_command_not_found

# color in man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# XDG
export XDG_CONFIG_HOME="/home/charles/.config/"
export XDG_DATA_HOME="/home/charles/.data/"

export EDITOR="vim"

# set tab to 4 spaces
tabs 4

# prompt syntax highlight
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
