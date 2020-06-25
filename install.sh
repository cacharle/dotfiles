#!/bin/sh

create_dotfile_link()
{
    ln -svf $DOTDIR/$1 $HOME/$2
}

create_dotfile_link_same()
{
    create_dotfile_link $1 $1
}

###########################
# dotfiles install script #
###########################

# dotfiles directory
[ -z $DOTDIR ] && DOTDIR=`pwd`

# Creating links
create_dotfile_link_same .zshrc
create_dotfile_link_same .bashrc
create_dotfile_link_same .vimrc
[ ! -d $HOME/.vim/plugin ] && mkdir -p $HOME/.vim/plugin
create_dotfile_link grep.vim .vim/plugin/grep.vim

[ ! -d $HOME/.xmonad ] && mkdir $HOME/.xmonad
create_dotfile_link xmonad.hs .xmonad/xmonad.hs

create_dotfile_link_same .gdbinit
create_dotfile_link_same .ghci
create_dotfile_link_same .gitconfig

[ ! -d $HOME/.config ] && mkdir $HOME/.config
create_dotfile_link redshift.conf .config/redshift.conf

create_dotfile_link_same slock/config.def.h

ln -sf $DOTDIR/.xinitrc $HOME/.xinitrc
ln -sf $DOTDIR/.zprofile $HOME/.zprofile

################
# dependencies #
################

[ $# -ge 1 ] || [ "$1" = "--ln" ] && exit 0
echo "Installing Dependencies"

# vim Plug
PLUGFILE=$HOME/.vim/autoload/plug.vim
PLUGURL='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
[ ! -f $PLUGFILE ] && echo "Downloading plug.vim" && \
    curl -fLo $PLUGFILE --create-dirs $PLUGURL
echo "Installing plug.vim Pluggins"
vim -c "PlugInstall" -c "qa"

# zsh pluggins
[ ! -d $HOME/.zsh ] && make $HOME/.zsh
# pure theme
[ ! -d $HOME/.zsh/pure ] && echo "Installing zsh pure theme" && \
    git clone https://github.com/sindresorhus/pure \
    $HOME/.zsh/pure
# syntax hightlighting
[ ! -d $HOME/.zsh/zsh-syntax-highlighting ] && echo "Installing zsh syntax highlighting plugin" && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    $HOME/.zsh/zsh-syntax-highlighting
# you should use
[ ! -d $HOME/.zsh/zsh-you-should-use ] && echo "Installing zsh you should use plugin" && \
    git clone https://github.com/MichaelAquilina/zsh-you-should-use \
    $HOME/.zsh/zsh-you-should-use
