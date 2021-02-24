###############
# zshrc       #
###############


# load aliases
source $XDG_CONFIG_HOME/zsh/aliases.zsh

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
        export FPATH="$FPATH:$XDG_DATA_HOME/zsh/pure"
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

# executed when changing directory
function chpwd() {
    content=$(ls | wc -l)
    ([ "$content" -lt 20 ] && ls -l) ||
        echo "$(pwd) contains $content entries"
    [ "$(stat -c "%U" .)" = "$USER" ] && touch .  # to sort by last cd
}

# add command-not-found package suggestion
#source /etc/zsh_command_not_found


fignore=(o hi) # ignore extensions in autocomplete

# pluggins
source $XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # prompt syntax highlight

export YSU_MESSAGE_POSITION="after"                                     # you-should-use message after command output
source $XDG_DATA_HOME/zsh/zsh-you-should-use/you-should-use.plugin.zsh  # alias reminder

# set tab to 4 spaces
tabs 4

export GPG_TTY=$(tty)  # fixing gpg fatal error about tty
