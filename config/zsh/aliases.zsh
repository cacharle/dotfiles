#!/bin/zsh

# color
alias grep='grep --color=auto'
alias tree='tree -C'

# --sudo $(which doas) --sudoloop --sudoflags'


# common commands
alias less='less -N'   # enable line number
# alias nvim='VIMINIT="" nvim'
alias v='nvim'
alias gdb='gdb -q'     # disable long intro message
alias sudo='sudo '     # enable color (the search for aliases continues)
alias doas='doas '     # same for doas
alias info='info --vi-keys'

# ls
if [ "$(uname)" = 'Linux' ]
then
    alias ls='ls --color=auto -Fh'
else
    alias ls='ls -G -Fh'
fi
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
alias lss='ls -Ssh'

# tree
alias tree='tree -FCA'
alias t='tree'
alias ta='tree -a'
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'
alias ti="tree --matchdirs -I __pycache__ -I node_modules -I '*.o' -I build"

# man
alias ma="man"
alias ma1="man 1"
alias ma2="man 2"
alias ma3="man 3"

# make
alias m='make'
alias mre='make re'
alias mclean='make clean'

# git
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gc='git commit'
alias gc!='git commit --amend'
alias gcmsg='git commit --message'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git diff --stat'
alias gl='git pull'
alias glg='git log --abbrev-commit --stat'
alias glgg='git log --abbrev-commit --graph'
alias glgo='git log --oneline --no-decorate'
alias gp='git push'
alias gcl='git clone --recurse-submodules'
alias gst='git status'
alias gs='git status'
alias gss='git status --short'
alias gco='git checkout'
alias gsta='git stash push'
alias gstp='git stash pop'
alias grv='git remote -v'
alias gra='git remote add'
alias gb='git branch'
gpa() {
    branch="$1"
    [ -z "$branch" ] && branch=$(git branch | grep '^\* .*$' | cut -d ' ' -f 2)
    git remote | xargs -I{} git push {} "$branch"
}
gpaf() {
    branch="$1"
    [ -z "$branch" ] && branch=$(git branch | grep '^\* .*$' | cut -d ' ' -f 2)
    git remote | xargs -I{} git push -f {} "$branch"
}

alias ytdl='youtube-dl --output "%(title)s.%(ext)s"'
alias ytdlp='youtube-dl --audio-format mp3 -i --output "%(playlist_index)s-%(title)s.%(ext)s"'
alias ytdla='youtube-dl --audio-format mp3 -i -x -f bestaudio/best --output "%(playlist_index)s-%(title)s.%(ext)s"'

# Linux specific aliases
[ ! "$(uname)" = 'Linux' ] && return

alias pacman='pacman --color=auto'
alias valgrindc='colour-valgrind'
alias yay='yay --color=auto'

# lpass (lastpass-cli)
alias lpassp='lpass show --password --clip'  # put password in clipboard

# helper to switch between dual and single monitor setup
alias dual='xrandr --output LVDS1 --primary --left-of VGA1 --output VGA1 --mode 1280x1024'
alias single='xrandr --output VGA1 --off'

# parent directory jump
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# bluetooth
alias bt='bluetoothctl'
alias bton='echo power on | bluetoothctl'
alias btoff='echo power off | bluetoothctl'

alias cagob='RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build'
alias cagor='RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run'

# wifi
wificonnect() { nmcli device wifi connect "$1" password "$2" ; }

alias qmvdest='qmv --format=do'

alias xclip='xclip -selection clipboard'

pacman_url() { pacman -Si "$1" | grep URL | tr -s ' ' | cut -d ' ' -f 3 ; }

alias filter-valgrind="sed -e 's/==[0-9]*==/==/' -e 's/0x[0-9A-F]*//'"

rc() {
    dir="$HOME/git/dotfiles/"
    filepath="$(
        find "$dir" -type f -not -path '*.git/*' |
        sed "s:$dir::" |
        fzf
    )" && "$EDITOR" "$dir$filepath"
    filename="$(basename "$filepath")"
    case "$filename" in
        .zshrc|aliases.zsh)
            echo 'Reloading zshrc'
            # shellcheck source=/dev/null
            . "$ZDOTDIR/.zshrc"
            ;;
        zprofile)
            echo 'Reloading zprofile'
            # shellcheck source=/dev/null
            . "$HOME/.zprofile"
            ;;
        xmonad.hs)
            echo 'Reloading xmonad'
            xmonad --recompile && xmonad --restart
            ;;
        config.py)
            echo 'Reloading qutebrowser config'
            qutebrowser :config-source
            ;;
    esac
}

vf() { f="$(fzf || exit 1)" && "$EDITOR" "$f" ; }

alias zathura='zathura --fork'

alias xset-reset='xset r rate 200 50'
alias open='xdg-open'
alias csi='rlwrap chicken-csi'

sdcv() {
    /usr/bin/sdcv -n --utf8-output --color "$@" 2>&1 |
        fold -s -w "$(tput cols)"
}

alias ffmpeg='ffmpeg -hide_banner'

sshvi() {
    ssh -t "$1" bash -o vi -i
}
