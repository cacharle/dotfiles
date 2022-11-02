if [ "$(uname)" = 'Linux' ]
    set -gx PATH "/usr/local/sbin:/usr/local/bin:/usr/bin:$HOME/.local/bin"
    set -gx MAIL 'me@cacharle.xyz'
    set -gx SUDO 'doas'
else if [ "$(uname)" = 'Darwin' ]
    set -gx PATH "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    set -gx PATH "$PATH:$HOME/.brew/bin:$HOME/git/dotfiles/bin:$HOME/bin"
    set -gx PATH "$PATH:$HOME/.local/share/go/bin"
    set -gx PATH "$PATH:$HOME/.local/bin"
    set -gx MAIL 'charles.cabergs@colruytgroup.com'
    set -gx SUDO 'sudo'
    set -gx LC_CTYPE 'en_US.UTF-8'
end

# applications
set -gx EDITOR 'nvim'
set -gx TERMINAL 'alacritty'
set -gx BROWSER 'qutebrowser'
set -gx BROWSERCLI 'w3m'

# [ -z "$TMUX" ] && set -gx TERM 'xterm-256color'

# XDG all the things
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
# config
set -gx XMONAD_CONFIG_HOME "$XDG_CONFIG_HOME/xmonad"
set -gx XMONAD_DATA_HOME "$XDG_DATA_HOME/xmonad"
set -gx XMONAD_CACHE_HOME "$XDG_CACHE_HOME/xmonad"
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -gx XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"
set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"
set -gx ASPELL_CONF "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
set -gx BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME"/bundle
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
# shellcheck disable SC2016
set -gx VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
set -gx IPYTHONDIR "$XDG_CONFIG_HOME/ipython"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
# data
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx BUNDLE_USER_PLUGIN "$XDG_DATA_HOME"/bundle
set -gx JULIA_DEPOT_PATH "$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
set -gx RLWRAP_HOME "$XDG_DATA_HOME/rlwrap"
set -gx STARDICT_DATA_DIR "$XDG_DATA_HOME/stardict"  # put dictionaries in a 'dic' subdirectory
# cache
set -gx HISTFILE "$XDG_CACHE_HOME/zsh/history"
set -gx LESSHISTFILE '-'  # no ~/.lesshst
set -gx PYTHON_EGG_CACHE "$XDG_CACHE_HOME/python-eggs"
set -gx BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
# runtime
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"

# shellcheck disable SC2155
# color in man (less pager)
set -gx LESS_TERMCAP_mb "$(printf '%b' '\e[1;32m')"
set -gx LESS_TERMCAP_md "$(printf '%b' '\e[1;32m')"
set -gx LESS_TERMCAP_me "$(printf '%b' '\e[0m')"
set -gx LESS_TERMCAP_se "$(printf '%b' '\e[0m')"
set -gx LESS_TERMCAP_so "$(printf '%b' '\e[01;33m')"
set -gx LESS_TERMCAP_ue "$(printf '%b' '\e[0m')"
set -gx LESS_TERMCAP_us "$(printf '%b' '\e[1;4;31m')"
set -gx LESS_TERMCAP_mr "$(tput rev)"
set -gx LESS_TERMCAP_mh "$(tput dim)"
set -gx LESS_TERMCAP_ZN "$(tput ssubm)"
set -gx LESS_TERMCAP_ZV "$(tput rsubm)"
set -gx LESS_TERMCAP_ZO "$(tput ssupm)"
set -gx LESS_TERMCAP_ZW "$(tput rsupm)"

set -gx MINIKUBE_IN_STYLE false  # disable cringe minikube emojies

set -gx HOMEBREW_NO_AUTO_UPDATE 1  # disable brew updating stuff when I install


if status is-interactive
    fish_vi_key_bindings
    function fish_greeting
    end

    if [ "$(uname)" = 'Linux' ]
        alias ls='ls --color=auto -Fh'
    else
        alias ls='ls -G -Fh'
    end

    abbr ll ls -l
    abbr lla ls -la

    # THEME PURE #
    set fish_function_path /home/charles/.config/fish/functions/theme-pure/functions/ $fish_function_path
    source /home/charles/.config/fish/functions/theme-pure/conf.d/pure.fish

    set pure_reverse_prompt_symbol_in_vimode true
end

if status is-login
    # . "$HOME/.config/zsh/.zshenv"

    if [ "$(uname)" = 'Linux' ] && [ "$(tty)" = '/dev/tty1' ]
        # https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
        # setting the keyrepeat delay and interval here as the default ones
        # since some applications reset the those if we use xset r rate 200 30 instead
        # exec startx "$XDG_CONFIG_HOME/x11/xinitrc" -- -ardelay 200 -arinterval 30
        # poweroff
    end
end
