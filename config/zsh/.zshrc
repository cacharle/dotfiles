#!/bin/zsh

# load aliases
# shellcheck source=/dev/null
. "$XDG_CONFIG_HOME/zsh/aliases.zsh"

# prompt
case $(tty) in
    /dev/tty[1-9])
        # %~ path ('~' if $HOME)
        # %B/%b start/stop bold
        # %F/%f start/stop color
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
    # ls on cd if not too much files
    content="$(find . -maxdepth 1 | wc -l)"
    ([ "$content" -lt 20 ] && ls -l) ||
        echo "$(pwd) contains $content entries"
    [ "$(uname)" = 'Linux' ] && [ "$(stat -c "%U" .)" = "$USER" ] && touch .  # to sort by last cd

    # change conda env if name of the directory is the name of an env
    # [ ! -d "$PWD/.git" ] && return
    # name="$(basename "$PWD")"
    # [ "$name" = $CONDA_DEFAULT_ENV ] && return
    # [ ! -e "$HOME/conda_envs" ] && conda env list > "$HOME/conda_envs"
    # < "$HOME/conda_envs" \
    #     cut -d ' ' -f 1 |
    #     sed -e '/^#/d' -e '/^$/d' -e '/^base$/d' |
    #     grep -q "$name" &&
    #         conda activate "$name"
}

# https://wiki.archlinux.org/title/Zsh#Shortcut_to_exit_shell_on_partial_command_line
exit_zsh() {
    exit
}
zle -N exit_zsh
bindkey '^D' exit_zsh

# shellcheck disable=SC2034,SC2039,SC3030
fignore=(.o .hi) # ignore extensions in autocomplete

# set tab to 4 spaces
tabs 4

GPG_TTY=$(tty)  # fixing gpg fatal error about tty
export GPG_TTY

export BAT_THEME='gruvbox-dark'  # gruvbox theme for bat (fancy cat)

# pluggins
# shellcheck source=/dev/null
. "$XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"  # prompt syntax highlight

export YSU_MESSAGE_POSITION="after"                                 # you-should-use message after command output
. "$XDG_DATA_HOME/zsh/zsh-you-should-use/you-should-use.plugin.zsh" # alias reminder

# install pkgfile package on Arch Linux
# run `pkgfile --update`
if [ "$(uname)" = 'Linux' ]
then
    .  /usr/share/doc/pkgfile/command-not-found.zsh
fi

# upload-config() {
#     scp -qr "$HOME/.vim"              cce424r@ds-train:
#     scp -q  "$HOME/.config/vim/vimrc" cce424r@ds-train:.vimrc
#
#     scp -qr "$HOME/.vim"              cce424r@ds-attic:
#     scp -q  "$HOME/.config/vim/vimrc" cce424r@ds-attic:.vimrc
# }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/usr/local/anaconda3/etc/profile.d/mamba.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

eval "$(opam env)"
