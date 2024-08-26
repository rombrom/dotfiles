setlocal spell
setlocal wrap

if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif

vmap <buffer> <silent> <Leader>k "kc[<C-r>k](<C-r>+)<Esc>
