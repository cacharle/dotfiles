#!/bin/zsh

# load aliases
# shellcheck source=/dev/null
. "$XDG_CONFIG_HOME/zsh/aliases.zsh"

# prompt
case $(tty) in
    /dev/tty[1-9])
        # %~ path ('~' if $HOME)
        # %B/%b start/stop bold
        # %B/%b start/stop color
        # shellcheck disable=SC2039,SC3003
        NEWLINE=$'\n'
        export PROMPT="${NEWLINE}%B%F{blue}%~%f${NEWLINE}%F{red}> %f%b"
        ;;
    *)
        # pure prompt
        export FPATH="$FPATH:$XDG_DATA_HOME/zsh/pure"
        export ZSH_THEME='pure'
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
COMPFILE="$XDG_CACHE_HOME/zsh/zcompdup-$ZSH_VERSION"
mkdir -p "$(dirname "$COMPFILE")"
compinit -d "$COMPFILE"
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

# setopt pushd_ignore_dups
# setopt extendedglob
setopt auto_cd          # cd without `cd` command
setopt list_rows_first  # cycle through row first in menu
setopt share_history    # share history between shells
setopt extended_history # command timestamp in history
setopt hist_ignore_dups # ignore duplicate entry in history

export HISTSIZE=10000
export SAVEHIST=5000

# executed when changing directory
chpwd() {
    content="$(find . -maxdepth 1 | wc -l)"
    ([ "$content" -lt 20 ] && ls -l) ||
        echo "$(pwd) contains $content entries"
    [ "$(stat -c "%U" .)" = "$USER" ] && touch .  # to sort by last cd
}

# shellcheck disable=SC2034,SC2039,SC3030
fignore=(o hi) # ignore extensions in autocomplete

# pluggins
# shellcheck source=/dev/null
. "$XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"  # prompt syntax highlight

export YSU_MESSAGE_POSITION="after"                                 # you-should-use message after command output
. "$XDG_DATA_HOME/zsh/zsh-you-should-use/you-should-use.plugin.zsh" # alias reminder

# set tab to 4 spaces
tabs 4

GPG_TTY=$(tty)  # fixing gpg fatal error about tty
export GPG_TTY
