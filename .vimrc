if &term =~# '^screen'
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors  " overwrite terminal theme
endif

so $HOME/dotfiles/.pluggins.vim  " source pluggins

let mapleader = ' '

syntax enable
set hidden
set noswapfile
filetype plugin on " add specific rules for certain file type
filetype plugin indent on
set number relativenumber
" browse list with tab
set wildmode=longest,list,full
set wildmenu
set nocompatible
set path+=**  " for recursive :find
" more intuitif split opening
set splitbelow
set splitright
set fcs+=vert:\   " split separator
" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" spit resizing
nnoremap zh <C-W>>
nnoremap zl <C-W><
nnoremap zj <C-W>-
nnoremap zk <C-W>+
" tab to space
" set expandtab
" set tabstop=4
" set shiftwidth=4
set smarttab
set autoindent
set smartindent
" search
set ignorecase
set smartcase
set hlsearch
set incsearch
" other
set ruler
set laststatus=2  " always a statusline
set scrolloff=2 " 2 line above scroll
set showcmd
set cursorline  " highlight current line
set noshowmode " unnecessary with status bar"
" where to place the .swp files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,~/var/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,~/var/tmp
" directory to ignore when searching in file tree (works with ctrlp)
set wildignore=*/tmp/*,*.o,*.so,*.swp,*.zip,*/node_modules/*,*/vendor/*,.bundle/*,bin/*,.git/*
" ctrlp ignore all stuff in the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ALE
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
    \ 'python': ['flake8']
    \ }
let g:ale_fixers = {
    \ 'python': ['autopep8']
    \ }

" let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
set background=dark
let g:lightline = {}
let g:lightline.colorscheme = 'jellybeans'
" let g:lightline.component_expand = {
"       \  'linter_checking': 'lightline#ale#checking',
"       \  'linter_warnings': 'lightline#ale#warnings',
"       \  'linter_errors': 'lightline#ale#errors',
"       \  'linter_ok': 'lightline#ale#ok',
"       \ }
" let g:lightline.component_type = {
"       \     'linter_checking': 'left',
"       \     'linter_warnings': 'warning',
"       \     'linter_errors': 'error',
"       \     'linter_ok': 'left',
"       \ }
" let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

let base16colorspace=256

" NERDTree shortcut
map <Leader>d :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFocus<CR>

" Global copy and paste
vnoremap <C-l> "+y
noremap <C-m> "+P

" 'Y' yank to the end of the line
:noremap Y y$

" remove trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" solves annoying delay went exiting insert mode
imap <ESC> <C-C>
imap jj <ESC>

" remove visual mode keybinding
map Q <ESC>
