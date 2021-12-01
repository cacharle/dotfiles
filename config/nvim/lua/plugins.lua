vim.cmd [[ packadd packer.nvim ]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'    -- plugin manager (can manage itself)
    use 'junegunn/vim-easy-align'   -- align
    use 'AndrewRadev/sideways.vim'  -- Move arguments sideways
    use 'FooSoft/vim-argwrap'       -- Put arguments on multiple lines
    use 'tpope/vim-eunuch'          -- basic commands on current file (Rename/Remove)
    use 'romainl/vim-cool'          -- only highlight search matches when searching

    -- nvim lsp configuration
    use {
        'neovim/nvim-lspconfig',
        config = function()
        end
    }

    -- rust lsp (needs rust-analyser)
    use {
        'simrat39/rust-tools.nvim',
        requires = {'neovim/nvim-lspconfig'},
        ft = {'rust'},
        config = function()
            require('rust-tools').setup {
                tools = {
                    inlay_hints = {
                        -- only_current_line = true,
                    },
                },
            }
        end
    }

    -- comment text objects
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- color scheme
    use {
        'ellisonleao/gruvbox.nvim',
        requires = {'rktjmp/lush.nvim'},
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme gruvbox ]]
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_bold = 1
            vim.g.gruvbox_termcolors = 256
            vim.g.gruvbox_contrast_dark = 'medium'
            vim.g.gruvbox_contrast_light = 'hard'
            vim.g.gruvbox_invert_selection = 0
        end
    }
    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'gruvbox',
                    icons_enabled = true,
                    section_separators = '',
                    component_separators = ''
                }
            }
        end
    }
    -- better syntax highlight for everything
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true
                },
                -- indent = { enable = true },
                -- TODO: could be neat
                -- incremental_selection = {
                --     enable = true,
                --     keymaps = {
                --         init_selection = "gnn",
                --         node_incremental = "grn",
                --         scope_incremental = "grc",
                --         node_decremental = "grm",
                --     }
                -- }
            }
            vim.cmd [[ highlight link pythonTSKeywordOperator Keyword ]]
        end
    }
    -- fuzzy finder (replace fzf.vim or ctrlp.vim)
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'kyazdani42/nvim-web-devicons', opt = true},
        },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<esc>'] = actions.close,
                            ['kj'] = actions.close,
                        }
                    },
                }
            }
        end

    }
    -- todos,fix,etc.. highlight and list
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                signs = false
            }
        end
    }

    use { 'nvim-treesitter/playground', opt = true, cmd = { 'TSPlaygroundToggle' } }
    use { '~/git/argwrap.nvim', opt = true }
end)
