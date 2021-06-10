""""""""""""""""
" vim pluggins "
""""""""""""""""

call plug#begin($XDG_DATA_HOME . '/vim/plugged')
    Plug 'junegunn/fzf.vim'             " file name/tags fuzzy finder (depends on fzf)
    Plug 'tpope/vim-eunuch'             " basic unix command in vim
    Plug 'tomtom/tcomment_vim'          " mininal commenter
    Plug 'itchyny/lightline.vim'        " minimal status bar
    Plug 'cacharle/vim-syntax-extra'    " syntax highlight of C operators
    Plug 'romainl/vim-cool'             " disable highlight after search
    Plug 'tpope/vim-fugitive'           " git wrapper
    Plug 'junegunn/vim-easy-align'      " align
    Plug 'ludovicchabant/vim-gutentags' " generate tags in project root
    Plug 'junegunn/goyo.vim'            " generate tags in project root
    Plug 'AndrewRadev/sideways.vim'     " Move arguments sideways
    Plug 'FooSoft/vim-argwrap'          " Put arguments on multiple lines

    Plug 'skammer/vim-css-color'

    " markdown preview in browser
    " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " syntax highlight for languages that aren't supported by default
    Plug 'tikhomirov/vim-glsl'                " glsl
    Plug 'cespare/vim-toml'                   " toml
    Plug 'ziglang/zig.vim'                    " zig
    Plug 'nikvdp/ejs-syntax'                  " ejs
    Plug 'vim-python/python-syntax'           " python (default highlight not great)

    " themes
    " Plug 'joshdick/onedark.vim'             " onedark
    Plug 'dracula/vim', {'as': 'vim'}       " dracula
    Plug 'altercation/vim-colors-solarized'   " solarized

    " intresting but not used
    Plug 'vim-scripts/rfc-syntax'             " rfc

    " my plugins
    Plug 'cacharle/c_formatter_42.vim'
    Plug 'cacharle/doxy42.vim'

    " s19 at home
    Plug 'cacharle/vim-42header'            " 42 header

    " Plug 'ctrlpvim/ctrlp.vim'           " Ctrl-P similar to vsc
call plug#end()
