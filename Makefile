DOTDIR = $(HOME)/dotfiles
ZSHRC = .zshrc
VIMRC = .vimrc
TMUXCONF = .tmux.conf
BASHRC = .bashrc
BASHALIAS = .bash_aliases
PROFILE = .profile
GHCI = .ghci
GDB = .gdbinit
CONFFILES = $(HOME)/$(ZSHRC) $(HOME)/$(VIMRC) $(HOME)/$(TMUXCONF) $(HOME)/$(BASHRC) \
			$(HOME)/$(BASHALIAS) $(HOME)/$(PROFILE) $(HOME)/$(GHCI) $(HOME)/$(GDB)

.PHONY: all
all: $(CONFFILES)

$(HOME)/$(ZSHRC): $(DOTDIR)/$(ZSHRC)
	touch $@
	echo "source $<" > $@

$(HOME)/$(VIMRC): $(DOTDIR)/$(VIMRC)
	touch $@
	echo "so $<" > $@

$(HOME)/$(TMUXCONF): $(DOTDIR)/$(TMUXCONF)
	touch $@
	echo "source-file $<" > $@

$(HOME)/$(BASHRC): $(DOTDIR)/$(BASHRC)
	touch $@
	echo "source $<" > $@

$(HOME)/$(BASHALIAS): $(DOTDIR)/$(BASHALIAS)
	touch $@
	echo "source $<" > $@

$(HOME)/$(PROFILE): $(DOTDIR)/$(PROFILE)
	touch $@
	echo "source $<" > $@

$(HOME)/$(GHCI): $(DOTDIR)/$(GHCI)
	touch $@
	cat $< > $@

$(HOME)/$(GDB): $(DOTDIR)/$(GDB)
	touch $@
	cat $< > $@

.PHONY: clean
clean:
	rm -f $(CONFFILES)

.PHONY: re
re: clean all
