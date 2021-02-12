""""""""""
" vimrc  "
""""""""""

" load pluggins {{{
if exists("$DOTDIR")
    source $DOTDIR/.pluggins.vim
else
    source .pluggins.vim
endif
" }}}

"""""""""""
" options "
"""""""""""

" common {{{
let mapleader = ' '         " set leader key to space
let maplocalleader = '-'    " set file local leader key to backslash
set nocompatible            " not compatible with vi
set number                  " line number
" set relativenumber          " line number relative to cursor
set numberwidth=1           " line numbers gutter autowidth
set cursorline              " highlight current line
set noshowmatch             " dont jump to pair bracket
set autoread                " reload files when changes happen outside vim
set autowrite               " auto write buf on certain events
set hidden                  " keep change in buffer when quitting window
set noswapfile              " disable swap files
set scrolloff=2             " line padding when scrolling
set textwidth=0             " when line wrap occurs
set wrapmargin=0            " disable auto line wrapping
set encoding=utf-8          " utf-8 encoding
set formatoptions-=t        " do not auto break line > 89 character
filetype plugin indent on   " allow to add specific rules for certain type of file
" set mouse=a                 " mouse scrolling (heretic)
" }}}

" browse list with tab {{{
set wildmode=longest,list,full
set wildmenu                " tab to cycle through completion options
set path+=**                " recursive :find
"}}}

" intuitif split opening {{{
set splitbelow
set splitright
set fcs+=vert:│             " split separator
" }}}

" tab {{{
set expandtab               " tab to space
set tabstop=4               " tab size
set shiftwidth=4
set smarttab
set autoindent
set smartindent
" }}}

" file search {{{
set ignorecase              " case insensitive
set smartcase
set hlsearch                " match highlight
set incsearch
" }}}

" status {{{
set laststatus=2            " always a statusline (all window)
set showcmd                 " show current partial command in the bottom right
set noshowmode              " dont show current mode (i.e --INSERT--)
" }}}

" fold {{{
set foldmethod=indent       " create fold based on the text indent
set nofoldenable            " not folded by default
" }}}

"""""""""""""""
" colorscheme "
"""""""""""""""

" one {{{
" let g:onedark_terminal_italics=1
" colorscheme onedark
" }}}
" dracula {{{
let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_colorterm = 0
colorscheme dracula
" }}}
" solarized {{{
" set t_Co=16
" let g:solarized_termcolors=16
" let g:solarized_visibility='low'  " visibility of invisible chars with set list
" set background=dark
" colorscheme solarized
" }}}
" lightline {{{
let g:lightline = {}
" let g:lightline.colorscheme = 'solarized'  " lightline theme to solarized
" let g:lightline.colorscheme = 'jellybeans'  " lightline theme to onedark
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" }}}

""""""""""""
" mappings "
""""""""""""

" split navigation {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <C-S-J> <C-W><S-J>
" nnoremap <C-S-K> <C-W><S-K>
" nnoremap <C-S-L> <C-W><S-L>
" nnoremap <C-S-H> <C-W><S-H>
nnoremap <leader>s= <C-W>=
" }}}

" common {{{
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
" common change until
nnoremap cu ct_
nnoremap cp ct)
nnoremap c, ct,
" }}}

" buffer navigation {{{
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader><TAB> :b#<CR>
nnoremap <leader>bl :ls<CR>
" }}}

" vimrc {{{
nnoremap <leader>rc :vsplit $DOTDIR/.vimrc<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>
" }}}

" c {{{
" create c function body from prototype
nnoremap gcf A<BS><CR>{<CR><CR>}<ESC>j

" initialise a school header file
function PutHeaderBoilerPlate()
    let l:filename = join(split(toupper(expand('%:t')), '\.'), "_")
    " echom l:filename
    call append(12, "#ifndef " . l:filename)
    call append(13, "# define " . l:filename)
    call append(15, "#endif")
endfunction
nnoremap gch :Stdheader<CR>:call PutHeaderBoilerPlate()<CR>

" put semicolon at the end of line
nnoremap <leader>; mqA;<ESC>`q
" doxygen format comments
autocmd Filetype c setlocal comments=s:/**,m:**,e:*/,s:/*,m:**,e:*/
autocmd Filetype cpp setlocal comments=s:/**,m:**,e:*/,s:/*,m:**,e:*/
" }}}

" cpp {{{
" Put Coplien Form boilerplate class
function PutCoplienFormFunc(name)
    let l:default_constructor = a:name . "();\n"
    let l:copy_constructor    = a:name . "(const " . a:name . "& other);\n"
    let l:copy_operator       = a:name . "& operator=(const " . a:name . "& other);\n"
    let l:destructor          = "~" . a:name . "();\n"

    execute "normal iclass " . a:name . "\n{\npublic:\n" . l:default_constructor . l:copy_constructor . l:copy_operator . l:destructor . "\nprivate:\n};\n"
    execute "normal <2{"
endfunction
" Put Coplien Form boilerplate according to filename
command! PutCoplienFormFile call PutCoplienFormFunc(split(expand('%:t'), '\.')[0])
command! -nargs=1 PutCoplienForm call PutCoplienFormFunc("<args>")
" }}}

" quickfix window toggle {{{
nnoremap <leader>q :call QuickfixToggle()<CR>
nnoremap <leader>n :cnext <CR>
nnoremap <leader>p :cprevious <CR>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}

function! CountScopeLines()
    normal! mq
    execute '/^}'
    let l:end_brace = line('.')
    execute '?^{'
    let l:start_brace = line('.')
    normal! k
    let l:scope_len = l:end_brace - l:start_brace - 1
    let l:scope_name = substitute(getline('.'), '\t', ' ', 'g')
    echom l:scope_len . ' lines in |' . l:scope_name . '|'
    normal! `q
endfunction
command! CountScopeLines call CountScopeLines()

" make {{{
nnoremap <leader>m :make all <CR>
" }}}

" hook {{{
" remove trailing white space on save
autocmd BufWritePre * %s/\s\+$//e
" dirty hack to disable this feature on markdown (autocmd! wouldn't work)
autocmd BufReadPre *.md autocmd! BufWritePre
" }}}

" filetype {{{
" real tab in c file for school projects
let g:c_syntax_for_h = 1   " filetype=c in header files instead of filetype=cpp
autocmd Filetype c setlocal noexpandtab
" std::cout << ... << std::endl; shortcut
autocmd Filetype cpp nnoremap <leader>cout istd::cout <<  << std::endl;<ESC>2F<hi
" vim fold method to marker
autocmd Filetype vim setlocal foldmethod=marker

autocmd FileType haskell set formatprg=stylish-haskell

autocmd FileType lisp,html,css,htmldjango setlocal shiftwidth=2
" }}}

""""""""""""
" pluggins "
""""""""""""

" ctrlp {{{
" directory to ignore when searching in file tree
set wildignore=*/doc/*,*/tmp/*,*.o,*.so,*.a,*.swp,*.zip,*/node_modules/*,*/vendor/*,.bundle/*,bin/*,.git/*,*.pyc
" ctrlp ignore all stuff in the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_mruf_case_sensitive = 0

nnoremap <leader>p :CtrlPTag<CR>
" }}}

" quick-scope {{{
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" man-plugin {{{
" runtime! ftplugin/man.vim
" let g:ft_man_open_mode = 'vert'    " open in a vertical split
" let g:ft_man_no_sect_fallback = 2  " if page specified fallback to page 2 (syscall pages)
" autocmd Filetype man unmap <buffer> q:  hmmmm??
" }}}

" ctrlp-funky {{{
" let g:ctrlp_funky_syntax_highlight = 1
" nnoremap <C-f> :CtrlPFunky<CR>
" }}}

" eazy-align {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

vnoremap <leader>c y:call system("xclip -selection clipboard", getreg("\""))<CR>
nnoremap <leader>v :call setreg("\"", system("xclip -selection clipboard -o"))<CR>p

let g:c_formatter_42_format_on_save = 0

let g:gutentags_ctags_exclude = ['doc/*', 'Makefile']
" let g:gutentags_ctags_exclude_wildignore = 1

let g:goyo_height = 90
