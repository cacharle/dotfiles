if [ "$(uname)" = 'Linux' ]
then
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:$HOME/.local/bin"
    export PATH="$PATH:$HOME/.local/share/go/bin"
    export MAIL='me@cacharle.xyz'
    export SUDO='doas'
elif [ "$(uname)" = 'Darwin' ]
then
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:$HOME/.brew/bin:$HOME/git/dotfiles/bin:$HOME/bin:/usr/local/anaconda3/bin"
    export PATH="$PATH:$HOME/.local/share/go/bin"
    export PATH="$PATH:$HOME/.local/bin"
    export MAIL='charles.cabergs@colruytgroup.com'
    export SUDO='sudo'
    export LC_CTYPE='en_US.UTF-8'
fi

# applications
export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='qutebrowser'
export BROWSERCLI='w3m'

[ -z "$TMUX" ] && export TERM='xterm-256color'

# XDG all the things
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# config
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME/xmonad"
export XMONAD_DATA_HOME="$XDG_DATA_HOME/xmonad"
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME/xmonad"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# shellcheck disable=SC2016
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
# data
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export RLWRAP_HOME="$XDG_DATA_HOME/rlwrap"
export STARDICT_DATA_DIR="$XDG_DATA_HOME/stardict"  # put dictionaries in a 'dic' subdirectory
# cache
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export LESSHISTFILE='-'  # no ~/.lesshst
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
# runtime
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# shellcheck disable=SC2155
# color in man (less pager)
export LESS_TERMCAP_mb="$(printf '%b' '\e[1;32m')"
export LESS_TERMCAP_md="$(printf '%b' '\e[1;32m')"
export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"
export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"
export LESS_TERMCAP_so="$(printf '%b' '\e[01;33m')"
export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"
export LESS_TERMCAP_us="$(printf '%b' '\e[1;4;31m')"
export LESS_TERMCAP_mr="$(tput rev)"
export LESS_TERMCAP_mh="$(tput dim)"
export LESS_TERMCAP_ZN="$(tput ssubm)"
export LESS_TERMCAP_ZV="$(tput rsubm)"
export LESS_TERMCAP_ZO="$(tput ssupm)"
export LESS_TERMCAP_ZW="$(tput rsupm)"

export MINIKUBE_IN_STYLE=false  # disable cringe minikube emojies

export CLOUT_SYNC_DIR="clout-sync/"
export CLOUT_SYNC_PATH="${XDG_DATA_HOME:-$HOME/.sync}/$CLOUT_SYNC_DIR"

export HOMEBREW_NO_AUTO_UPDATE=1  # disable brew updating stuff when I install

