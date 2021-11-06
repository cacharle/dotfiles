local map = vim.api.nvim_set_keymap

map('', 'Y', 'y$', {})                              -- 'Y' yank to the end of the line
map('i', 'kj', '<ESC>', {})                         -- kj to exit insert mode
map('', 'Q', '<nop>', {})                           -- remove visual mode keybinding
map('n', '<leader>sc', ':source $MYVIMRC<CR>', {})  -- source vimrc
map('n', '<leader>;', 'mqA;<ESC>`q', {})            -- put semicolon at the end of line
map('n', 'cu', 'ct_', {})                           -- common change until

-- split navigation
map('n', '<C-J>', '<C-W><C-J>', {})
map('n', '<C-K>', '<C-W><C-K>', {})
map('n', '<C-L>', '<C-W><C-L>', {})
map('n', '<C-H>', '<C-W><C-H>', {})
map('n', '<leader>s=', '<C-W>=', {})

-- search with very magic
map('n', ' /', '/\v', {})
map('n', ' ?', '?\v', {})

-- ctrl-j/k to navigate commands history
map('c', '<C-j>', '<down>', {})
map('c', '<C-k>', '<up>', {})

-- -- hook
-- -- remove trailing white space on save
-- autocmd vimrc BufWritePre * %s/\s\+$//e
-- -- dirty hack to disable this feature on markdown (autocmd! wouldn't work)
-- autocmd vimrc BufReadPre *.md autocmd! BufWritePre


-- augroup vimrc_files
--     autocmd!
--     -- school c
--     autocmd Filetype c setlocal noexpandtab
--     autocmd Filetype c setlocal comments=s:/**,m:**,e:*/,s:/*,m:**,e:*/
--     -- std::cout << ... << std::endl; shortcut
--     autocmd Filetype cpp nnoremap <leader>cout istd::cout <<  << std::endl;<ESC>2F<hi
--     autocmd Filetype vim setlocal foldmethod=marker -- vim fold method to marker
--     autocmd FileType haskell set formatprg=stylish-haskell
--     autocmd FileType lisp,html,css,htmldjango setlocal shiftwidth=2
-- augroup END

-- pluggins
--
-- eazy-align
map('x', 'ga', ':EasyAlign<CR>', {})
map('n', 'ga', ':EasyAlign<CR>', {})

-- nnoremap <leader>l :SidewaysRight<CR>
-- nnoremap <leader>h :SidewaysLeft<CR>
-- nnoremap <leader>w :ArgWrap<CR>
-- nnoremap <leader>ss :setlocal spell!<CR>

map('n', '<C-p>', ':Telescope git_files<CR>', {})
map('n', '<C-h>', ':Telescope help_tags<CR>', {})
