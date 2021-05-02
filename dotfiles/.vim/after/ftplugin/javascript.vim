setlocal include=from
setlocal isfname+=@-@ " some node_modules are namespaced with an @
setlocal omnifunc=ale#completion#OmniFunc

" Snippets, sort of.
inoreabbrev <buffer> desc( describe('', () => {});<Esc>F'i<C-r>=Eatchar('\s')<Cr>
inoreabbrev <buffer> it( it('', () => {});<Esc>F'i<C-r>=Eatchar('\s')<Cr>

" Init ALE mappings, etc.
call webdev#Init()
