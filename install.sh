#!/bin/sh

###########################
# dotfiles install script #
###########################

# dotfiles directory
[ -z $DOTDIR ] && DOTDIR=`pwd`

# Creating links
ln -sf $DOTDIR/.zshrc $HOME/.zshrc
ln -sf $DOTDIR/.vimrc $HOME/.vimrc

[ ! -d $HOME/.xmonad ] && mkdir $HOME/.xmonad
ln -sf $DOTDIR/xmonad.hs $HOME/.xmonad/xmonad.hs

ln -sf $DOTDIR/.gdbinit $HOME/.gdbinit
ln -sf $DOTDIR/.ghci $HOME/.ghci
ln -sf $DOTDIR/.gitconfig $HOME/.gitconfig

[ ! -d $HOME/.config ] && mkdir $HOME/.config
ln -sf $DOTDIR/redshift.conf $HOME/.config/redshift.conf

ln -sf $DOTDIR/.xinitrc $HOME/.xinitrc
ln -sf $DOTDIR/.zprofile $HOME/.zprofile

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
[ ! -d $HOME/.zsh/pure ] && \
    git clone https://github.com/sindresorhus/pure \
    $HOME/.zsh/pure
# syntax hightlighting
[ ! -d $HOME/.zsh/zsh-syntax-highlighting ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    $HOME/.zsh/zsh-syntax-highlighting
# you should use
[ ! -d $HOME/.zsh/zsh-you-should-use ] && \
    git clone https://github.com/MichaelAquilina/zsh-you-should-use \
    $HOME/.zsh/zsh-you-should-use
