nnoremap <leader>g :set operatorfunc=<SID>GrepOp<CR>g@
vnoremap <leader>g :<C-u>call <SID>GrepOp(visualmode())<CR>

function! s:GrepOp(type)
    let saved = @@

    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    silent redraw!
    let g:quickfix_is_open = 1
    copen
    let @@ = saved
endfunction

nnoremap <leader>gn :cnext<CR>
nnoremap <leader>gp :cprevious<CR>
