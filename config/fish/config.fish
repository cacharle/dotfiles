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

set -gx GPG_TTY "$(tty)"
# valgrind requires this to work on arch linux (from: https://bbs.archlinux.org/viewtopic.php?id=276422)
set -gx DEBUGINFOD_URLS 'https://debuginfod.archlinux.org'


if status is-interactive
    fish_vi_key_bindings
    function fish_greeting
    end

    # common commands
    alias grep 'grep --color=auto'
    alias pacman 'pacman --color=auto'
    alias yay 'yay --color=auto'
    alias tree 'tree -C'
    alias less 'less -N'   # enable line number
    alias nvim 'VIMINIT="" /usr/bin/nvim'
    alias v 'nvim'
    alias gdb 'gdb -q'     # disable long intro message
    alias sudo 'sudo '     # enable color (the search for aliases continues)
    alias doas 'doas '     # same for doas
    alias info 'info --vi-keys'
    alias xclip 'xclip -selection clipboard'

    if [ "$(uname)" = 'Linux' ]
        alias ls='ls --color=auto -Fh'
    else
        alias ls='ls -G -Fh'
    end
    abbr ll 'ls -l'
    abbr la 'ls -A'
    abbr lla 'ls -Al'
    abbr lss 'ls -Ssh'

    # tree
    alias tree 'tree -FCA'
    abbr t 'tree'
    abbr ta 'tree -a'
    abbr t1 'tree -L 1'
    abbr t2 'tree -L 2'
    abbr t3 'tree -L 3'
    alias ti="tree --matchdirs -I __pycache__ -I node_modules -I '*.o' -I build"

    # git
    abbr ga 'git add'
    abbr gaa 'git add --all'
    abbr gau 'git add --update'
    abbr gc 'git commit'
    abbr gc! 'git commit --amend'
    abbr gcmsg 'git commit --message'
    abbr gd 'git diff'
    abbr gds 'git diff --staged'
    abbr gdt 'git diff --stat'
    abbr gl 'git pull'
    abbr glg 'git log --abbrev-commit --stat'
    abbr glgg 'git log --abbrev-commit --graph'
    abbr glgo 'git log --oneline --no-decorate'
    abbr gp 'git push'
    abbr gcl 'git clone --recurse-submodules'
    abbr gst 'git status'
    abbr gs 'git status'
    abbr gss 'git status --short'
    abbr gco 'git checkout'
    abbr gsta 'git stash push'
    abbr gstp 'git stash pop'
    abbr grv 'git remote -v'
    abbr gra 'git remote add'
    abbr gb 'git branch'
    function gpa
        set -f branch "$argv[-1]"
        # if branch not specified, get current branch
        [ -z "$branch" ] && set -f branch "$(git branch | grep '^\* .*$' | cut -d ' ' -f 2)"
        git remote | xargs -I{} git push {} $argv[..-2] "$branch"
    end

    # yt-dlp
    abbr ytdl 'yt-dlp --output "%(title)s.%(ext)s"'
    abbr ytdlp 'yt-dlp --audio-format mp3 -i --output "%(playlist_index)s-%(title)s.%(ext)s"'
    abbr ytdla 'yt-dlp --audio-format mp3 -i -x -f bestaudio/best --output "%(playlist_index)s-%(title)s.%(ext)s"'

    # wifi
    function wificonnect
        nmcli device wifi connect "$argv[1]" password "$argv[2]"
    end

    abbr qmvdest 'qmv --format=do'
    abbr zathura 'zathura --fork'
    alias open 'xdg-open'
    alias ffmpeg 'ffmpeg -hide_banner'

    # THEME PURE #
    set fish_function_path /home/charles/.config/fish/functions/theme-pure/functions/ $fish_function_path
    source /home/charles/.config/fish/functions/theme-pure/conf.d/pure.fish

    set pure_reverse_prompt_symbol_in_vimode true
end

if status is-login
    if [ "$(uname)" = 'Linux' ] && [ "$(tty)" = '/dev/tty1' ]
        # https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
        # setting the keyrepeat delay and interval here as the default ones
        # since some applications reset the those if we use xset r rate 200 30 instead
        startx "$XDG_CONFIG_HOME/x11/xinitrc" -- -ardelay 200 -arinterval 30
        poweroff
    end
end
