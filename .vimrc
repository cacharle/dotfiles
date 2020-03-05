""""""""""
" vimrc  "
""""""""""

" source pluggins
source $HOME/dotfiles/.pluggins.vim


" common
let mapleader = ' '         " set leader key to space
syntax enable               " enable syntax
set hidden                  " keep change in buffer when quitting window
set noswapfile              " disable swap files
set nocompatible            " not compatible with vi
filetype plugin indent on   " allow to add specific rules for certain type of file
set number relativenumber   " line number relative to cursor
set cursorline              " highlight current line
set noshowmatch             " dont jump to pair bracket
set autoread                " reload files when changes happen outside vim
set scrolloff=2             " line padding when scrolling
set encoding=utf-8          " utf-8 encoding
set textwidth=89            " when line wrap occurs

" browse list with tab
set wildmode=longest,list,full
set wildmenu                " tab to cycle through completion options
set path+=**                " recursive :find

" intuitif split opening
set splitbelow
set splitright
set fcs+=vert:\             " no split separator

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" spit resizing
nnoremap zh <C-W>>
nnoremap zl <C-W><
nnoremap zj <C-W>-
nnoremap zk <C-W>+

" tab
set expandtab               " tab to space
set tabstop=4               " tab size
set shiftwidth=4
set smarttab
set autoindent
set smartindent

" file search
set ignorecase              " case insensitive
set smartcase
set hlsearch                " match highlight
set incsearch

" status
set laststatus=2            " always a statusline (all window)
set showcmd                 " show current partial command in the bottom right
set noshowmode              " dont show current mode (i.e --INSERT--)


" ctrlp pluggin
" directory to ignore when searching in file tree
set wildignore=*/tmp/*,*.o,*.so,*.swp,*.zip,*/node_modules/*,*/vendor/*,.bundle/*,bin/*,.git/*
" ctrlp ignore all stuff in the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" colorscheme
let g:onedark_terminal_italics=1
colorscheme onedark
let g:lightline = {}
let g:lightline.colorscheme = 'one'  " lightline theme to onedark

" mappings
" 'Y' yank to the end of the line
noremap Y y$

" solves annoying delay went exiting insert mode
imap <ESC> <C-C>
" jj or kk to exit insert mode
imap jj <ESC>
imap kk <ESC>
" remove visual mode keybinding
map Q <ESC>
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" remove trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" real tab in c file for school projects
autocmd Filetype c setlocal noexpandtab
