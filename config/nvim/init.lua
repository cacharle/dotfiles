require('plugins')

-- common
vim.g.mapleader = ' '         -- set leader key to space
vim.g.maplocalleader = '-'    -- set file local leader key to backslash
vim.opt.compatible = false          -- not compatible with vi
vim.opt.number = true                -- line number
vim.opt.numberwidth = 1           -- line numbers gutter autowidth
vim.opt.cursorline = true       -- highlight current line
vim.opt.showmatch = false      -- dont jump to pair bracket
vim.opt.autoread = true         -- reload files when changes happen outside vim
vim.opt.autowrite = true        -- auto write buf on certain events
vim.opt.hidden = true           -- keep change in buffer when quitting window
vim.opt.swapfile = false       -- disable swap files
vim.opt.scrolloff = 2 -- line padding when scrolling
vim.opt.textwidth = 0 -- when line wrap occurs
vim.opt.wrapmargin = 0 -- disable auto line wrapping
vim.opt.clipboard = 'unnamedplus'  -- use system clipboard
vim.g.c_syntax_for_h = 1     -- .h file use C filetype instead of C++
vim.opt.encoding = "utf-8"          -- utf-8 encoding
-- filetype plugin indent on   -- allow to add specific rules for certain type of file
-- set mouse=a                 " mouse scrolling (heretic)
vim.opt.shellredir = ">"            -- don't inclue stderr when reading a command
-- intuitif split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

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
vim.opt.hlsearch  = true              -- match highlight
vim.opt.incsearch = true

-- status
vim.opt.laststatus=2            -- always a statusline (all window)
vim.opt.showcmd = true                -- show current partial command in the bottom right
vim.opt.showmode = false             -- dont show current mode (i.e --INSERT--)

-- colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd [[ colorscheme gruvbox ]]
vim.g.gruvbox_italic = 1
vim.g.gruvbox_bold = 1
vim.g.gruvbox_termcolors = 256
vim.g.gruvbox_contrast_dark = 'medium'
vim.g.gruvbox_contrast_light = 'hard'
vim.g.gruvbox_invert_selection = 0

local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<esc>'] = actions.close,
            }
        }
    }
}

require('lualine').setup {
    options = {
        theme = 'gruvbox',
        icons_enabled = false,
        section_separators = '',
        component_separators = ''
    }
}

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    }
}

require('nvim_comment').setup()

require('mappings')
