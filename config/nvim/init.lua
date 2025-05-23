-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy wants leader to be defined before
vim.g.mapleader = " "              -- set leader key to space
vim.g.maplocalleader = "-"         -- set file local leader key to backslash

require("lazy").setup("plugins")

-- common
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
vim.opt.equalalways = true

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

vim.opt.ch = 0                   -- make command line invisible when not typing command

-- remove ugly treesitter error highlight
-- require "nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil

local augroup = vim.api.nvim_create_augroup("cacharle_init_group", {})

-- run PackerCompile when we modify plugins.lua
-- vim.api.nvim_create_autocmd(
--     "BufWritePost",
--     {
--         pattern = "plugins.lua",
--         command = "source <afile> | PackerCompile",
--         group = augroup
--     }
-- )

-- remove trailing white space on save
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = "*",
        callback = function()
            -- Create a mark to avoid jumping to a line that got it's spaces removed
            vim.cmd("normal! mA")
            vim.cmd([[ %s/\s\+$//e ]])
            vim.cmd("normal! `A")
        end,
        group = augroup
    }
)

-- set filttype for *.sql.j2 files
vim.api.nvim_create_autocmd(
    "BufReadPre",
    {
        pattern = "*.sql.j2",
        callback = function() vim.opt.filetype = "sql" end,
        group = augroup,
    }
)

-- set filttype for gitignore
vim.api.nvim_create_autocmd(
    "BufReadPre",
    {
        pattern = ".gitignore",
        callback = function() vim.opt.filetype = "gitignore" end,
        group = augroup,
    }
)

-- -- Format go files on save
-- vim.api.nvim_create_autocmd(
--     "BufWritePre",
--     { command = [[ !go fmt % ]], pattern = "*.go", group = augroup }
-- )

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "haskell",
        callback = function() vim.opt_local.formatprg = "stylish-haskell" end,
        group = augroup,
    }
)

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "lisp,html,css,htmldjango",
        callback = function() vim.opt_local.shiftwidth = 2 end,
        group = augroup,
    }
)

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "go",
        callback = function() vim.opt_local.expandtab = false end,
        group = augroup,
    }
)

vim.api.nvim_create_autocmd(
    "VimResized",
    {
        pattern = "*",
        command = [[ wincmd = ]],
        group = augroup,
    }
)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp,c,cuda",
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})

vim.cmd [[ highlight link DiffAdd    GruvboxGreenSign  ]]
vim.cmd [[ highlight link DiffChange GruvboxYellowSign ]]
vim.cmd [[ highlight link DiffDelete GruvboxRedSign    ]]
-- vim.cmd [[ highlight DiffText   link GruvboxGreenSign ]]

require("mappings")
