###############
# zshrc       #
###############


[ -z $DOTDIR ] && export DOTDIR=$HOME/git/dotfiles # FIXME have to change path manually if install elsewhere

# load aliases
source $DOTDIR/.zsh_aliases

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

# executed when changing directory
function chpwd() {
    content=$(ls | wc -l)
    ([ "$content" -lt 20 ] && ls -l) ||
        echo "$(pwd) contains $content entries"
    #[ "$(stat -c "%U" .)" = "$USER" ] && touch .  # to sort by last cd
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

# ls colors
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

#XDG
export XDG_CONFIG_HOME="/home/charles/.config/"
export XDG_DATA_HOME="/home/charles/.data/"

export EDITOR="vim"
export TERM="xterm-256color"
export MAIL='me@cacharle.xyz'
export BROWSER='chromium'
export BROWSERCLI='w3m'

# ignore filetypes in autocomplete
fignore=(o hi)

# pluggins
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # prompt syntax highlight

export YSU_MESSAGE_POSITION="after"                                    # you-should-use message after command output
source $HOME/.zsh/zsh-you-should-use/you-should-use.plugin.zsh         # alias reminder

# set tab to 4 spaces
#tabs 4

export LFS=/mnt

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:$HOME/.brew/bin:$DOTDIR/bin:$HOME/bin"

export GPG_TTY=$(tty)  # fixing gpg fatal error about tty

export MINISHELL_TEST_BONUS=yes
export MINISHELL_TEST_PAGER=vim
export MINISHELL_TEST_FLAGS=-DMINISHELL_TEST

19fetch
