setlocal include=from
setlocal isfname+=@-@ " some node_modules are namespaced with an @

if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif
