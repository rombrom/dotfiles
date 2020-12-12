" the default qf.vim ftplugin from the distribution only sets the statusline of
" the Quickfix List. We want our own statusline, dammit.

if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1
