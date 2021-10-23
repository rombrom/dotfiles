setlocal spell
setlocal wrap

call init#webdev()

" for vim-surround: map <Leader>k to make a link.
" this creates a new surroundable object to ASCI k
let b:surround_107 = "[\r]()"
vmap <buffer> <silent> <Leader>k Skgv<Esc>P
