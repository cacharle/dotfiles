" plugins
call plug#begin()
    Plug 'ctrlpvim/ctrlp.vim'         " Ctrl-P similar to vsc
    Plug 'tpope/vim-eunuch'           " basic unix command in vim
    Plug 'tomtom/tcomment_vim'        " mininal commenter
    Plug 'itchyny/lightline.vim'      " minimal status bar
    Plug 'sheerun/vim-polyglot'       " better syntax highlight
    Plug 'romainl/vim-cool'           " disable highlight after search

    " s19 at home
    Plug 'pbondoer/vim-42header'      " 42 header

    " themes
    " Plug 'joshdick/onedark.vim'        " onedark
    " Plug 'dracula/vim', {'as': 'vim'}  " dracula
    Plug 'altercation/vim-colors-solarized'  " solarized

    " intresting but not used
    " Plug 'unblevable/quick-scope'     " highlight first char to jump to word
    " Plug 'justinmk/vim-syntax-extra'  " better syntax highlight
call plug#end()
