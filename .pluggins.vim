""""""""""""""""
" vim pluggins "
""""""""""""""""

call plug#begin()
    Plug 'ctrlpvim/ctrlp.vim'                 " Ctrl-P similar to vsc
    Plug 'tpope/vim-eunuch'                   " basic unix command in vim
    Plug 'tomtom/tcomment_vim'                " mininal commenter
    Plug 'itchyny/lightline.vim'              " minimal status bar
    Plug 'cacharle/vim-syntax-extra'          " syntax highlight of C operators
    Plug 'romainl/vim-cool'                   " disable highlight after search
    Plug 'tpope/vim-fugitive'                 " git wrapper
    Plug 'junegunn/vim-easy-align'            " align

    " markdown preview in browser
    " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " syntax highlight for languages that aren't supported by default
    Plug 'tikhomirov/vim-glsl'                " glsl
    Plug 'cespare/vim-toml'                   " toml
    Plug 'ziglang/zig.vim'                    " zig
    Plug 'vim-scripts/applescript.vim'        " applescript
    Plug 'vim-scripts/rfc-syntax'             " rfc

    " s19 at home
    Plug 'cacharle/vim-42header'              " 42 header

    " themes
    " Plug 'joshdick/onedark.vim'             " onedark
    Plug 'dracula/vim', {'as': 'vim'}       " dracula
    Plug 'altercation/vim-colors-solarized'   " solarized

    " intresting but not used
    " Plug 'sheerun/vim-polyglot'             " better syntax highlight
    " Plug 'unblevable/quick-scope'           " highlight first char to jump to word
    " Plug 'jez/vim-superman'                 " man pages in vim (too slow)
    " Plug 'tacahiroy/ctrlp-funky'              " extension to search function
    " Plug 'easymotion/vim-easymotion' " TODO very intresting

    Plug '~/git/c_formatter_42.vim'
    Plug '~/git/doxy42.vim'
call plug#end()
