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
    copen
    let @@ = saved
endfunction
