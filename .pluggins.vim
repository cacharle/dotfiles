" plugins
call plug#begin()
    Plug 'scrooloose/nerdtree'  " file tree
    " Plug 'scrooloose/nerdcommenter'  " comment multiple line
    "Plug 'vim-airline/vim-airline'  " status bar
    Plug 'itchyny/lightline.vim'  " minimal status bar
    " Plug 'jiangmiao/auto-pairs' " pair stuff autocomplete
    " Plug 'yuttie/comfortable-motion.vim' " scroll
    Plug 'ctrlpvim/ctrlp.vim' " Ctrl-P similar to vsc
    "Plug 'lervag/vimtex' " LaTex improvement
    " better highlight syntax
    Plug 'justinmk/vim-syntax-extra'
    "Plug 'junegunn/goyo.vim'  " focus mode
    " Plug 'w0rp/ale'  " lint
    Plug 'maximbaz/lightline-ale'
    Plug 'romainl/vim-cool' " disable highlight after search
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }  " markdown preview with math typeset
    Plug 'vim-scripts/awk.vim'
    Plug 'sheerun/vim-polyglot'  " better syntax highlighting
    " Plug 'neovimhaskell/haskell-vim'  " vim haskell highlighting
    Plug 'haya14busa/incsearch.vim'  " better incsearch


    " themes
    "Plug 'mhartington/oceanic-next'
    Plug 'joshdick/onedark.vim'
    " Plug 'morhetz/gruvbox'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    "Plug 'jdkanani/vim-material-theme'
    Plug 'ayu-theme/ayu-vim'
    "Plug 'vim-airline/vim-airline-themes'
    Plug 'connorholyday/vim-snazzy'
    Plug 'chriskempson/base16-vim'

    Plug 'tomtom/tcomment_vim'  " other min commenter
    " Plug 'tpope/vim-commentary' " minimalistic commenter
    Plug 'tpope/vim-surround' " surround stuff
    Plug 'tpope/vim-eunuch'  " command in vim

    "Plug 'terryma/vim-multiple-cursors'
    "Plug 'Valloric/YouCompleteMe' " autocomplete
    "Plug 'fatih/vim-go'
    "Plug 'Yggdroot/indentLine'  " indent guide
call plug#end()
