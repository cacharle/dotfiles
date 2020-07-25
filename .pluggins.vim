""""""""""""""""
" vim pluggins "
""""""""""""""""

call plug#begin()
    Plug 'ctrlpvim/ctrlp.vim'                 " Ctrl-P similar to vsc
    Plug 'tpope/vim-eunuch'                   " basic unix command in vim
    Plug 'tomtom/tcomment_vim'                " mininal commenter
    Plug 'itchyny/lightline.vim'              " minimal status bar
    Plug 'HappyTramp/vim-syntax-extra'        " syntax highlight of C operators
    Plug 'romainl/vim-cool'                   " disable highlight after search

    " syntax highlight for languages that aren't supported by default
    Plug 'tikhomirov/vim-glsl'                " glsl
    Plug 'cespare/vim-toml'                   " toml
    Plug 'ziglang/zig.vim'                    " zig

    " s19 at home
    Plug 'HappyTramp/vim-42header'            " 42 header

    " Plug 'HappyTramp/vim-htheader'            " my header

    " themes
    " Plug 'joshdick/onedark.vim'             " onedark
    " Plug 'dracula/vim', {'as': 'vim'}       " dracula
    Plug 'altercation/vim-colors-solarized'   " solarized

    " intresting but not used
    " Plug 'sheerun/vim-polyglot'             " better syntax highlight
    " Plug 'unblevable/quick-scope'           " highlight first char to jump to word
call plug#end()
