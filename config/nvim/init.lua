require('plugins')

-- common
vim.g.mapleader = ' '              -- set leader key to space
vim.g.maplocalleader = '-'         -- set file local leader key to backslash
vim.opt.compatible = false         -- not compatible with vi
vim.opt.number = true              -- line number
vim.opt.numberwidth = 1            -- line numbers gutter autowidth
vim.opt.cursorline = true          -- highlight current line
vim.opt.showmatch = false          -- dont jump to pair bracket
vim.opt.autoread = true            -- reload files when changes happen outside vim
vim.opt.autowrite = true           -- auto write buf on certain events
vim.opt.hidden = true              -- keep change in buffer when quitting window
vim.opt.swapfile = false           -- disable swap files
vim.opt.scrolloff = 2              -- line padding when scrolling
vim.opt.textwidth = 0              -- when line wrap occurs
vim.opt.wrapmargin = 0             -- disable auto line wrapping
vim.opt.clipboard = 'unnamedplus'  -- use system clipboard
vim.g.c_syntax_for_h = 1           -- .h file use C filetype instead of C++
vim.opt.encoding = "utf-8"         -- utf-8 encoding
vim.opt.shellredir = ">"           -- don't inclue stderr when reading a command

-- intuitif split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

-- tab
vim.opt.expandtab = true         -- tab to space
vim.opt.tabstop = 4              -- tab size
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- file search
vim.opt.ignorecase = true        -- case insensitive
vim.opt.smartcase = true
vim.opt.hlsearch  = true         -- match highlight
vim.opt.incsearch = true

-- status
vim.opt.laststatus=2             -- always a statusline (all window)
vim.opt.showcmd = true           -- show current partial command in the bottom right
vim.opt.showmode = false         -- dont show current mode (i.e --INSERT--)

-- require 'nvim-treesitter.highlight'
-- local hlmap = vim.treesitter.TSHighlighter.hl_map
-- hlmap.error = nil

-- local on_attach = function(_, bufnr)
--     local opts = {noremap = true, silent = true }
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
-- end

-- require('lspconfig').pyright.setup { on_attach = on_attach }

vim.cmd [[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]

require('mappings')
