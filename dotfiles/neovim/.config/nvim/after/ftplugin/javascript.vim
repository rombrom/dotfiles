setlocal include=from
setlocal isfname+=@-@ " some node_modules are namespaced with an @

if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif

nnoremap <Leader>he cl&#<C-r>=char2nr(getreg('+'))<Cr>;<Esc>
