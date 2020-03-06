""""""""""
" vimrc  "
""""""""""

" load pluggins
source $HOME/dotfiles/.pluggins.vim

" common
let mapleader = ' '         " set leader key to space
let maplocalleader = '-'    " set file local leader key to backslash
set nocompatible            " not compatible with vi
set number                  " line number
set relativenumber          " line number relative to cursor
set numberwidth=1           " line numbers gutter autowidth
set cursorline              " highlight current line
set noshowmatch             " dont jump to pair bracket
set autoread                " reload files when changes happen outside vim
set hidden                  " keep change in buffer when quitting window
set noswapfile              " disable swap files
set scrolloff=2             " line padding when scrolling
set textwidth=89            " when line wrap occurs
set encoding=utf-8          " utf-8 encoding
filetype plugin indent on   " allow to add specific rules for certain type of file

" browse list with tab
set wildmode=longest,list,full
set wildmenu                " tab to cycle through completion options
set path+=**                " recursive :find

" intuitif split opening
set splitbelow
set splitright
set fcs+=vert:\             " no split separator

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

" fold
set foldmethod=indent       " create fold based on the text indent

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

""""""""""""
" mappings "
""""""""""""

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 'Y' yank to the end of the line
noremap Y y$
" solves annoying delay went exiting insert mode
inoremap <ESC> <C-C>
" kj to exit insert mode
inoremap kj <ESC>
" remove visual mode keybinding
noremap Q <nop>
" remove command line window keybinding
noremap q: <nop>
" search with very magic
nnoremap / /\v
nnoremap ? ?\v
" move line up and down
nnoremap _ ddkP
nnoremap + ddp
" long move up/down
nnoremap ( 10k
nnoremap ) 10j
" tag nagigation
nnoremap <leader>] <C-]>
nnoremap <leader>t <C-t>
" buffer navigation
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader><TAB> :b#<CR>
nnoremap <leader>l :ls<CR>
" file manipulation with leader
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

" open vimrc in split
nnoremap <leader>rc :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>src :source $MYVIMRC<cr>

" file toggle
nnoremap <leader>z zi

" create c function body from prototype
nnoremap gcf A<BS><CR>{<CR><CR>}<ESC>

" put semicolon at the end of line
nnoremap <leader>; mqA;<ESC>`q

" remove trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" initialise buf for fold toggle
autocmd BufReadPre * :normal zMzi

" real tab in c file for school projects
autocmd Filetype c setlocal noexpandtab
