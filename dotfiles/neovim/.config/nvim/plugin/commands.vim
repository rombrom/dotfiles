" Diff changes before save
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Open scratch buffer
command Scratch split scratch | setlocal buftype=nofile bufhidden=hide noswapfile textwidth=79

" List todos in HEAD vs. default branch
command! Todo cgetexpr Grep('TODO', '$(git files)')

" Files
command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
