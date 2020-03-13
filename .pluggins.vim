" plugins
call plug#begin()
    Plug 'dracula/vim', {'as': 'dracula' } " theme
    Plug 'ctrlpvim/ctrlp.vim'              " Ctrl-P similar to vsc
    Plug 'tpope/vim-eunuch'                " basic unix command in vim
    Plug 'tomtom/tcomment_vim'             " mininal commenter
    Plug 'itchyny/lightline.vim'           " minimal status bar

    " bloat??
    Plug 'romainl/vim-cool'                " disable highlight after search
    Plug 'justinmk/vim-syntax-extra'       " better syntax highlight
    Plug 'sheerun/vim-polyglot'            " better syntax highlight
call plug#end()
