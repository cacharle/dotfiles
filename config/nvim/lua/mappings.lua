local map = vim.api.nvim_set_keymap

map('', 'Y', 'y$', {})                              -- 'Y' yank to the end of the line
map('i', 'kj', '<esc>', {})                         -- kj to exit insert mode
map('', 'Q', '<nop>', {})                           -- remove visual mode keybinding
map('n', '<leader>sc', '<cmd>source $MYVIMRC<cr>', {})  -- source vimrc
map('n', '<leader>;', 'mqA;<esc>`q', {})            -- put semicolon at the end of line
map('n', 'cu', 'ct_', {})                           -- common change until
map('n', '<leader>ss', '<cmd>setlocal spell!<cr>', {})  -- toggle spelling check
map('n', '<leader>]', '<C-]>', {})  -- toggle spelling check
map('n', '<leader>t', '<C-t>', {})  -- toggle spelling check

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

-- python breakpoints
vim.cmd [[ autocmd FileType python nmap <leader>bd mq:g/^\s*breakpoint()$/d<cr>`q ]]
vim.cmd [[ autocmd FileType python nmap <leader>ba mqobreakpoint()<esc>`q ]]

-- pluggins
map('x', 'ga', '<cmd>EasyAlign<cr>', {})
map('n', 'ga', '<cmd>EasyAlign<cr>', {})

map('n', '<leader>l', '<cmd>SidewaysRight<cr>', {})
map('n', '<leader>h', '<cmd>SidewaysLeft<cr>', {})

map('n', '<leader>w', '<cmd>ArgWrap<cr>', {})
