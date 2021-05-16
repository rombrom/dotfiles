setlocal include=from
setlocal isfname+=@-@ " some node_modules are namespaced with an @
setlocal omnifunc=ale#completion#OmniFunc

" Init ALE mappings, etc.
call webdev#Init()
