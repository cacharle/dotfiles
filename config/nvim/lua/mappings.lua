local map = vim.api.nvim_set_keymap

map('', 'Y', 'y$', {})                              -- 'Y' yank to the end of the line
map('i', 'kj', '<esc>', {})                         -- kj to exit insert mode
map('', 'Q', '<nop>', {})                           -- remove visual mode keybinding
map('n', '<leader>sc', '<cmd>source $MYVIMRC<cr>', {})  -- source vimrc
map('n', '<leader>;', 'mqA;<esc>`q', {})            -- put semicolon at the end of line
map('n', 'cu', 'ct_', {})                           -- common change until

-- split navigation
map('n', '<C-j>', '<C-w><C-j>', {})
map('n', '<C-k>', '<C-w><C-k>', {})
map('n', '<C-l>', '<C-w><C-l>', {})
map('n', '<C-h>', '<C-w><C-h>', {})
map('n', '<leader>s=', '<C-w>=', {})

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

-- python breakpoints
vim.cmd [[ autocmd FileType python nmap <leader>bd :g/^\s*breakpoint()$/d<cr> ]]
vim.cmd [[ autocmd FileType python nmap <leader>ba mqobreakpoint()<esc>`q ]]

-- pluggins
--
-- eazy-align
map('x', 'ga', '<cmd>EasyAlign<cr>', {})
map('n', 'ga', '<cmd>EasyAlign<cr>', {})

-- nnoremap <leader>l :SidewaysRight<CR>
-- nnoremap <leader>h :SidewaysLeft<CR>
-- nnoremap <leader>w :ArgWrap<CR>
-- nnoremap <leader>ss :setlocal spell!<CR>

map('n', '<C-p>', '<cmd>Telescope git_files<cr>', {})
map('n', '<f2>', '<cmd>Telescope help_tags<cr>', {})
map('n', '<leader>;', '<cmd>Telescope commands<cr>', {})
