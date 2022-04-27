require("plugins")

-- common
vim.g.mapleader = " "              -- set leader key to space
vim.g.maplocalleader = "-"         -- set file local leader key to backslash
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
vim.opt.clipboard = "unnamedplus"  -- use system clipboard
vim.g.c_syntax_for_h = 1           -- .h file use C filetype instead of C++
vim.opt.encoding = "utf-8"         -- utf-8 encoding
vim.opt.shellredir = ">"           -- don"t inclue stderr when reading a command

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
vim.opt.laststatus = 2           -- always a statusline (all window)
vim.opt.showcmd = true           -- show current partial command in the bottom right
vim.opt.showmode = false         -- dont show current mode (i.e --INSERT--)

-- remove ugly treesitter error highlight
-- require "nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil

local augroup = vim.api.nvim_create_augroup("cacharle_init_group", {})

-- run PackerCompile when we modify plugins.lua
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        command = "source <afile> | PackerCompile",
        pattern = "plugins.lua",
        group = augroup
    }
)

-- remove trailing white space on save
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { command = [[ %s/\s\+$//e ]], pattern = "*", group = augroup }
)

-- set filttype for *.sql.j2 files
vim.api.nvim_create_autocmd(
    "BufReadPre",
    { command = "set ft=sql", pattern = "*.sql.j2", group = augroup }
)

require("mappings")
