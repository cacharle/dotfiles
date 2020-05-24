###############
# zshrc       #
###############

export DOTFILES=$HOME/dotfiles

# load aliases
source $DOTFILES/.zsh_aliases

# prompt
case `tty` in
    /dev/tty[1-9])
        # %~ path ('~' if $HOME)
        # %B/%b start/stop bold
        # %B/%b start/stop color
        NEWLINE=$'\n'
        export PROMPT="${NEWLINE}%B%F{blue}%~%f${NEWLINE}%F{red}> %f%b"
        ;;
    *)
        # pure prompt
        export FPATH="$FPATH:$HOME/.zsh/pure"
        ZSH_THEME="pure"
        autoload -U promptinit
        promptinit
        prompt pure
        ;;
esac

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select                          # menu like
zstyle ':completion:*' matcher-list '' \
    'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=*' 'r:|=* l:|=* r:|=*'  # case insensitive
zmodload zsh/complist
compinit
# _comp_options+=(globdots)

# vim keybindings in tab completion menu (https://www.youtube.com/watch?v=eLEo4OQ-cuQ)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vim keybindings in prompt
bindkey -v
export KEYTIMEOUT=1

setopt auto_cd          # cd without `cd` command
# setopt pushd_ignore_dups
setopt list_rows_first  # cycle through row first in menu
# setopt extendedglob

# executed when changind directory
function chpwd() {
    content=`ls | wc -l`
    ([ $content -lt 30 ] && tree -L 1) ||
        echo "$(pwd) contains $content entries"
}

# add command-not-found package suggestion
#source /etc/zsh_command_not_found

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

#XDG
export XDG_CONFIG_HOME="/home/charles/.config/"
export XDG_DATA_HOME="/home/charles/.data/"

export EDITOR="vim"
export TERM="st-256color"
# export TERM="xterm-256color"

# mail
export MAIL='charles.cabergs@gmail.com'

# ignore filetypes in autocomplete
fignore=(o hi)

# pluggins
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # prompt syntax highlight

export YSU_MESSAGE_POSITION="after"                                    # you-should-use message after command output
source $HOME/.zsh/zsh-you-should-use/you-should-use.plugin.zsh         # alias reminder

# set tab to 4 spaces
tabs 4

export LFS=/mnt
