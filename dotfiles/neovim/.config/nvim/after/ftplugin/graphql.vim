if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif
