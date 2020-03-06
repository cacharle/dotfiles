#!/bin/sh

###########################
# dotfiles install script #
###########################

# dotfiles directory
[ -z $DOTDIR ] && DOTDIR=`pwd`

# Creating links
ls -sf $DOTDIR/.zshrc $HOME/.zshrc
ls -sf $DOTDIR/.vimrc $HOME/.vimrc

[ ! -d $HOME/.xmonad ] && mkdir $HOME/.xmonad
ls -sf $DOTDIR/xmonad.hs $HOME/.xmonad/xmonad.hs

ls -sf $DOTDIR/.gdbinit $HOME/.gdbinit
ls -sf $DOTDIR/.ghci $HOME/.ghci
ls -sf $DOTDIR/.gitconfig $HOME/.gitconfig

[ ! -d $HOME/.config ] && mkdir $HOME/.config
ls -sf $DOTDIR/redshift.conf $HOME/.config/redshift.conf

################
# dependencies #
################

# vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall" -c "qa"

# zsh pluggins
[ ! -d $HOME/.zsh ] && make $HOME/.zsh
# pure theme
git clone https://github.com/sindresorhus/pure $HOME/.zsh/pure
# syntax hightlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    $HOME/.zsh/zsh-syntax-highlighting
# you should use
git clone https://github.com/MichaelAquilina/zsh-you-should-use \
    $HOME/.zsh/zsh-you-should-use
