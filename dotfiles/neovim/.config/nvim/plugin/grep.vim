" TODO: rewrite to lua?
function! GrepOperator(type) abort
  silent execute "grep '" . utils#EscapeRegExp(utils#getTarget(a:type)) . "'"
endfunction

nnoremap <silent> <Leader>g :set operatorfunc=GrepOperator<Cr>g@
vnoremap <silent> <Leader>g :<C-u>call GrepOperator(visualmode())<Cr>
nnoremap <silent> <Leader>gg :grep '<C-r>=utils#EscapeRegExp(expand('<cword>'))<Cr>'<Cr>
nnoremap <silent> <Leader>gG :grep '<C-r>=utils#EscapeRegExp(expand('<cWORD>'))<Cr>'<Cr>
