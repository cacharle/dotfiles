vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'    -- plugin manager (can manage itself)
    use 'terrortylor/nvim-comment'  -- comments
    use 'junegunn/vim-easy-align'   -- align
    use 'AndrewRadev/sideways.vim'  -- Move arguments sideways
    use 'FooSoft/vim-argwrap'       -- Put arguments on multiple lines
    use 'tpope/vim-eunuch'          -- basic commands on current file (Rename/Remove)
    use 'romainl/vim-cool'          -- only highlight search matches when searching
    use 'neovim/nvim-lspconfig'     -- nvim lsp configuration

    -- color scheme
    use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- better syntax highlight for everything
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- fuzzy finder (replace fzf.vim or ctrlp.vim)
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
end)
