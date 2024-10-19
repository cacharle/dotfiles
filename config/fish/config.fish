if [ "$(uname)" = 'Linux' ]
    set -gx PATH "/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/cuda/bin:/usr/bin/vendor_perl"
    set -gx MAIL 'me@cacharle.xyz'
    set -gx SUDO 'doas'
else if [ "$(uname)" = 'Darwin' ]
    set -gx PATH "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    set -gx PATH "$PATH:$HOME/.brew/bin:$HOME/git/dotfiles/bin:$HOME/bin"
    set -gx MAIL 'charles.cabergs@colruytgroup.com'
    set -gx SUDO 'sudo'
    set -gx LC_CTYPE 'en_US.UTF-8'
end

set -gx PATH "$PATH:$HOME/.local/share/go/bin"
set -gx PATH "$PATH:$HOME/.local/share/cargo/bin"
set -gx PATH "$PATH:$HOME/.local/share/npm/bin"
set -gx PATH "$PATH:$HOME/.local/bin"
# odin specific, remove later (http://odin-lang.org/docs/install/#for-linux-and-other-nix)
set -gx PATH "$PATH:$HOME/git/odin"
set -gx PATH "$PATH:$HOME/git/ols"

# ESP32 rust toolchain
# . "$HOME/export-esp.sh"

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
set -gx KUBECONFIG "$XDG_CONFIG_HOME/kubectl/config"
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
set -gx ANSIBLE_HOME "$XDG_CONFIG_HOME/ansible"
set -gx ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible.cfg"
# data
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx BUNDLE_USER_PLUGIN "$XDG_DATA_HOME"/bundle
set -gx JULIA_DEPOT_PATH "$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
set -gx RLWRAP_HOME "$XDG_DATA_HOME/rlwrap"
set -gx STARDICT_DATA_DIR "$XDG_DATA_HOME/stardict"  # put dictionaries in a 'dic' subdirectory
set -gx VIRTUALFISH_HOME "$XDG_DATA_HOME/virtualfish"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
# cache
set -gx HISTFILE "$XDG_CACHE_HOME/zsh/history"
set -gx LESSHISTFILE '-'  # no ~/.lesshst
set -gx PYTHON_EGG_CACHE "$XDG_CACHE_HOME/python-eggs"
set -gx BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
set -gx ANSIBLE_GALAXY_CACHE_DIR "$XDG_CACHE_HOME/ansible/galaxy_cache"
# runtime
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -gx GHCUP_USE_XDG_DIRS 'true'
set -gx STACK_XDG '1'

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

set -gx HOST "$(cat /etc/hostname)"  # for compatibility with Xmonad.Layout.OnHost
set -gx LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib"  # https://github.com/rust-lang/rust/issues/24677

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
    if [ "$(uname)" = 'Darwin' ]
        alias nvim 'VIMINIT="" /usr/local/bin/nvim'
    else
        alias nvim 'VIMINIT="" /usr/bin/nvim'
    end
    alias v 'nvim'
    alias gdb 'gdb -q'     # disable long intro message
    alias sudo 'sudo '     # enable color (the search for aliases continues)
    alias doas 'doas '     # same for doas
    alias info 'info --vi-keys'
    alias xclip 'xclip -selection clipboard'
    alias mutt 'neomutt'
    alias mbsync 'mbsync -c "$XDG_CONFIG_HOME/isync/mbsyncrc"'
    alias arduino-cli='arduino-cli --config-file $XDG_CONFIG_HOME/arduino15/arduino-cli.yaml'
	# alias nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings

    if command -qv eza
        alias ls='eza --git --git-repos --mounts --classify --icons'
    else
        if [ "$(uname)" = 'Linux' ]
            alias ls='ls --color=auto -Fh'
        else
            alias ls='ls -G -Fh'
        end
    end
    abbr ll 'ls -l'
    abbr la 'ls -A'
    abbr lla 'ls -Al'
    abbr lss 'ls -Ssh'

    # tree
    if command -qv eza
        alias tree='ls -T'
        alias ti="ls -T --git-ignore"
    else
        alias tree 'tree -FC'
        alias ti="tree --matchdirs -I __pycache__ -I node_modules -I '*.o' -I build"
    end
    abbr t 'tree'
    abbr ta 'tree -a'
    abbr t1 'tree -L 1'
    abbr t2 'tree -L 2'
    abbr t3 'tree -L 3'

    if command -qv bat
        alias cat='bat --theme gruvbox-dark'
        # Doesn't work with aws .. help
        # set -gx MANPAGER "sh -c 'col -bx | bat --theme gruvbox-dark -l man -p'"
        set -gx MANPAGER "bat --theme gruvbox-dark -p"
    end

    if command -qv delta
        function rgd --wraps delta
            rg --json -C 2 $argv | delta
        end
    end

    # git
    abbr ga 'git add'
    abbr gaa 'git add --all'
    abbr gau 'git add --update'
    abbr gc 'git commit'
    abbr gc! 'git commit --amend'
    abbr gc!! 'git commit --amend --no-edit'
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
    abbr gt 'git tag'
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

    # kubectl
    alias k 'kubectl'

    # wifi
    function wificonnect
        nmcli device wifi connect "$argv[1]" password "$argv[2]"
    end

    abbr qmvdest 'qmv --format=do'
    abbr zathura 'zathura --fork'
    alias open 'xdg-open'
    alias ffmpeg 'ffmpeg -hide_banner'

    # THEME PURE #
    #set fish_function_path /home/charles/.config/fish/functions/theme-pure/functions/ $fish_function_path
    #source /home/charles/.config/fish/functions/theme-pure/conf.d/pure.fish

    set pure_reverse_prompt_symbol_in_vimode true

    function fish_command_not_found
        if [ "$(uname)" = 'Linux' ]
            /usr/bin/pkgfile $argv[1]
        end
    end

    # from: https://virtualfish.readthedocs.io/en/latest/install.html#customizing-your-fish-prompt
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
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
