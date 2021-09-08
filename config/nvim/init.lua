-- xdg
-- set runtimepath^=$XDG_CONFIG_HOME/vim
-- set runtimepath+=$XDG_DATA_HOME/vim
-- set runtimepath+=$XDG_CONFIG_HOME/vim/after
--
-- set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
-- set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after
--
-- let g:netrw_home = $XDG_DATA_HOME . '/vim'
-- call mkdir($XDG_DATA_HOME . '/vim/spell', 'p')
-- set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p')
--
-- set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p')
-- set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p')
-- set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p')

source $XDG_CONFIG_HOME/vim/pluggins.vim  -- load pluggins

-- TODO
-- vim.fn <-- functions
-- vim.opt <-- options
-- replace fzf by telescope
-- better syntax highlight with tree-sitter
-- ..........................................................

-- common
let mapleader = ' '         -- set leader key to space
let maplocalleader = '-'    -- set file local leader key to backslash
-- vint: -ProhibitSetNoCompatible
vim.opt.nocompatible = true          -- not compatible with vi
vim.opt.number  =true                -- line number
-- set relativenumber          " line number relative to cursor
vim.opt.numberwidth = 1           -- line numbers gutter autowidth
vim.opt.cursorline = true       -- highlight current line
vim.opt.noshowmatch = true      -- dont jump to pair bracket
vim.opt.autoread = true         -- reload files when changes happen outside vim
vim.opt.autowrite = true        -- auto write buf on certain events
vim.opt.hidden = true           -- keep change in buffer when quitting window
vim.opt.noswapfile = true       -- disable swap files
vim.opt.scrolloff=2 = true      -- line padding when scrolling
vim.opt.textwidth=0 = true      -- when line wrap occurs
vim.opt.wrapmargin=0 = true     -- disable auto line wrapping
vim.opt.encoding = "utf-8"          -- utf-8 encoding
-- scriptencoding "utf-8"
-- vim.opt.formatoptions -= 't'        -- do not auto break line > 89 character
filetype plugin indent on   -- allow to add specific rules for certain type of file
-- set mouse=a                 " mouse scrolling (heretic)
vim.opt.shellredir=>            -- don't inclue stderr when reading a command

-- browse list with tab
vim.opt.wildmode=longest,list,full
vim.opt.wildmenu                -- tab to cycle through completion options
vim.opt.path+=**                -- recursive :find

-- intuitif split opening
vim.opt.splitbelow
vim.opt.splitright
vim.opt.fillchars+=vert:│       -- split separator

-- tab
vim.opt.expandtab = true              -- tab to space
vim.opt.tabstop = 4               -- tab size
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- file search
vim.opt.ignorecase = true             -- case insensitive
vim.opt.smartcase = true
vim.opt.hlsearch                -- match highlight
vim.opt.incsearch = true

-- status
vim.opt.laststatus=2            -- always a statusline (all window)
vim.opt.showcmd                 -- show current partial command in the bottom right
vim.opt.noshowmode              -- dont show current mode (i.e --INSERT--)

-- fold
vim.opt.foldmethod=indent       -- create fold based on the text indent
vim.opt.nofoldenable            -- not folded by default

--""""""""""""""
-- colorscheme "
--""""""""""""""

vim.opt.background=dark
-- one
-- let g:onedark_terminal_italics=1
-- colorscheme onedark
-- dracula
-- let g:dracula_bold = 1
-- let g:dracula_italic = 1
-- let g:dracula_colorterm = 0
-- silent! colorscheme dracula
-- solarized
-- set t_Co=16
-- let g:solarized_termcolors=16
-- let g:solarized_visibility='low'  " visibility of invisible chars with set list
-- silent! colorscheme solarized

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_invert_selection=0
colorscheme gruvbox

-- lightline
let g:lightline = {}
-- let g:lightline.colorscheme = 'solarized'  " lightline theme to solarized
-- let g:lightline.colorscheme = 'jellybeans'  " lightline theme to onedark
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

--"""""""""""
-- mappings "
--"""""""""""

-- split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
-- nnoremap <C-S-J> <C-W><S-J>
-- nnoremap <C-S-K> <C-W><S-K>
-- nnoremap <C-S-L> <C-W><S-L>
-- nnoremap <C-S-H> <C-W><S-H>
nnoremap <leader>s= <C-W>=

-- common
-- 'Y' yank to the end of the line
noremap Y y$
-- solves annoying delay went exiting insert mode
inoremap <ESC> <C-C>
-- kj to exit insert mode
inoremap kj <ESC>
-- remove visual mode keybinding
noremap Q <nop>
-- search with very magic
nnoremap / /\v
nnoremap ? ?\v
-- move line up and down
nnoremap _ ddkP
nnoremap + ddp
-- long move up/down
nnoremap ( 10k
nnoremap ) 10j
-- tag nagigation
nnoremap <leader>] <C-]>
nnoremap <leader>t <C-t>
-- common change until
nnoremap cu ct_
nnoremap cp ct)
nnoremap c, ct,

-- buffer navigation
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader><TAB> :b#<CR>
nnoremap <leader>bl :ls<CR>

nnoremap <leader>sc :source $MYVIMRC<cr>  -- source vimrc

-- c
-- create c function body from prototype
nnoremap gcf A<BS><CR>{<CR><CR>}<ESC>j

-- initialise a school header file
function PutHeaderBoilerPlate()
    let l:filename = join(split(toupper(expand('%:t')), '\.'), '_')
    -- echom l:filename
    call append(12, '#ifndef ' . l:filename)
    call append(13, '# define ' . l:filename)
    call append(15, '#endif')
endfunction
nnoremap gch :Stdheader<CR>:call PutHeaderBoilerPlate()<CR>

-- put semicolon at the end of line
nnoremap <leader>; mqA;<ESC>`q

-- cpp
-- Put Coplien Form boilerplate class
function PutCoplienFormFunc(name)
    let l:default_constructor = a:name . '();\n'
    let l:copy_constructor    = a:name . '(const ' . a:name . '& other);\n'
    let l:copy_operator       = a:name . '& operator=(const ' . a:name . '& other);\n'
    let l:destructor          = '~' . a:name . '();\n'

    execute 'normal iclass ' . a:name . '\n{\npublic:\n' . l:default_constructor . l:copy_constructor . l:copy_operator . l:destructor . '\nprivate:\n};\n'
    execute 'normal <2{'
endfunction
-- Put Coplien Form boilerplate according to filename
command! PutCoplienFormFile call PutCoplienFormFunc(split(expand('%:t'), '\.')[0])
command! -nargs=1 PutCoplienForm call PutCoplienFormFunc(--<args>")

-- quickfix window toggle
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

-- make
nnoremap <leader>m :make all <CR>

augroup vimrc
    autocmd!
augroup END

-- hook
-- remove trailing white space on save
autocmd vimrc BufWritePre * %s/\s\+$//e
-- dirty hack to disable this feature on markdown (autocmd! wouldn't work)
autocmd vimrc BufReadPre *.md autocmd! BufWritePre

-- filetype
-- real tab in c file for school projects
let g:c_syntax_for_h = 1   -- filetype=c in header files instead of filetype=cpp

augroup vimrc_files
    autocmd!
    -- school c
    autocmd Filetype c setlocal noexpandtab
    autocmd Filetype c setlocal comments=s:/**,m:**,e:*/,s:/*,m:**,e:*/
    -- std::cout << ... << std::endl; shortcut
    autocmd Filetype cpp nnoremap <leader>cout istd::cout <<  << std::endl;<ESC>2F<hi
    autocmd Filetype vim setlocal foldmethod=marker -- vim fold method to marker
    autocmd FileType haskell set formatprg=stylish-haskell
    autocmd FileType lisp,html,css,htmldjango setlocal shiftwidth=2
augroup END

--"""""""""""
-- pluggins "
--"""""""""""

-- directory to ignore when searching in file tree
vim.opt.wildignore=*/doc/*,*/tmp/*,*.o,*.so,*.a,*.swp,*.zip,*/node_modules/*,*/vendor/*,.bundle/*,bin/*,.git/*,*.pyc

-- ctrlp
-- ctrlp ignore all stuff in the .gitignore
-- let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
-- let g:ctrlp_working_path_mode = 'rw'
-- let g:ctrlp_mruf_case_sensitive = 0
--
-- nnoremap <leader>p :CtrlPTag<CR>

-- fzf.vim
nnoremap <C-p> :GFiles --exclude-standard --others --cached<CR>
nnoremap <leader>p :Tags<CR>

-- quick-scope
-- let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

-- man-plugin
-- runtime! ftplugin/man.vim
-- let g:ft_man_open_mode = 'vert'    " open in a vertical split
-- let g:ft_man_no_sect_fallback = 2  " if page specified fallback to page 2 (syscall pages)
-- autocmd Filetype man unmap <buffer> q:  hmmmm??

-- eazy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

vnoremap <leader>c y:call system(--xclip -selection clipboard", getreg("\""))<CR>
nnoremap <leader>v :call setreg(--\"", system("xclip -selection clipboard -o"))<CR>p

let g:c_formatter_42_format_on_save = 0

let g:gutentags_ctags_exclude = ['doc/*', 'docs/*', 'Makefile', '.mypy_cache', '.pytest_cache', '.tox', 'build/*', 'dist/*']
-- let g:gutentags_ctags_exclude_wildignore = 1

let g:goyo_height = 90
let g:goyo_width = 100

vim.opt.viminfo+=n$XDG_CACHE_HOME/vim/viminfo

let g:python_highlight_all = 1

nnoremap <leader>l :SidewaysRight<CR>
nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>w :ArgWrap<CR>
nnoremap <leader>ss :setlocal spell!<CR>

hi link juliaFunctionCall Identifier
hi link juliaParDelim Delimiter

autocmd Filetype markdown nnoremap <leader>r :execute 'silent !pandoc % -o %:r.pdf &' \| redraw! \| echom 'Converting to pdf: ' . expand('%:r') . '.pdf'<CR>
