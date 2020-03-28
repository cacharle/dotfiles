" plugins
call plug#begin()
    Plug 'joshdick/onedark.vim'       " theme
    Plug 'ctrlpvim/ctrlp.vim'         " Ctrl-P similar to vsc
    Plug 'tpope/vim-eunuch'           " basic unix command in vim
    Plug 'tomtom/tcomment_vim'        " mininal commenter
    Plug 'itchyny/lightline.vim'      " minimal status bar
    Plug 'unblevable/quick-scope'     " highlight first char to jump to word

    " bloat??
    Plug 'romainl/vim-cool'           " disable highlight after search
    Plug 'justinmk/vim-syntax-extra'  " better syntax highlight
    Plug 'sheerun/vim-polyglot'       " better syntax highlight
call plug#end()
