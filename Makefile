DOTDIR    = $(HOME)/dotfiles
ZSHRC     = .zshrc
VIMRC     = .vimrc
BASHRC    = .bashrc
BASHALIAS = .bash_aliases
GHCI      = .ghci
GDB       = .gdbinit
GITCONFIG = .gitconfig
XMONADCONFIG = .xmonad/xmonad.hs
CONFFILES = $(addprefix $(HOME), $(ZSHRC) $(VIMRC) $(BASHRC) $(BASHALIAS) $(GHCI) $(GDB) $(GITCONFIG)) $(XMONADCONFIG)

.PHONY: all
all: $(CONFFILES)

$(HOME)/$(ZSHRC): $(DOTDIR)/$(ZSHRC)
	touch $@
	echo "source $<" > $@

$(HOME)/$(VIMRC): $(DOTDIR)/$(VIMRC)
	touch $@
	echo "so $<" > $@

$(HOME)/$(BASHRC): $(DOTDIR)/$(BASHRC)
	touch $@
	echo "source $<" > $@

$(HOME)/$(BASHALIAS): $(DOTDIR)/$(BASHALIAS)
	touch $@
	echo "source $<" > $@

$(HOME)/$(GHCI): $(DOTDIR)/$(GHCI)
	touch $@
	cat $< > $@

$(HOME)/$(GDB): $(DOTDIR)/$(GDB)
	touch $@
	cat $< > $@

$(HOME)/$(GITCONFIG): $(DOTDIR)/$(GITCONFIG)
	touch $@
	cat $< >> $@

$(HOME)/$(XMONADCONFIG): $(DOTDIR)/xmonad.hs
	cp $< $@

.PHONY: clean
clean:
	rm -f $(CONFFILES)

.PHONY: re
re: clean all

# .PHONY: dependencies
# dependencies:
# 	@echo "Installing vim-plug (plugin manager)"
# 	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
# 		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 	@echo "Installing vim plugins"
# 	vim -c "PlugInstall" -c "qa"
# 	@echo "Installing oh-my-zsh"
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# @echo "Installing zsh-syntax-highlighting"
	# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	# 	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
