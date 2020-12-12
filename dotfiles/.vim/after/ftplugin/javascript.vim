setlocal include=from
setlocal isfname+=@-@ " some node_modules are namespaced with an @
setlocal omnifunc=ale#completion#OmniFunc

" Snippets, sort of.
inoreabbrev <buffer> desc( describe('', () => {});<Esc>F'i<C-r>=Eatchar('\s')<Cr>
inoreabbrev <buffer> it( it('', () => {});<Esc>F'i<C-r>=Eatchar('\s')<Cr>

" mappings
nmap <buffer> <C-]> <Plug>(ale_go_to_definition)
nmap <buffer> <C-w>] <Plug>(ale_go_to_definition_in_split)
nmap <buffer> <C-w><C-]> <Plug>(ale_go_to_definition_in_split)
nmap <buffer> <Leader>dd <Plug>(ale_go_to_definition)
nmap <buffer> <Leader>ds <Plug>(ale_go_to_definition_in_split)
nmap <buffer> <Leader>dt <Plug>(ale_go_to_definition_in_tab)
nmap <buffer> <Leader>dv <Plug>(ale_go_to_definition_in_vsplit)

" add -relative option to find
nnoremap <buffer> <silent> <Plug>(ale_find_references) :ALEFindReferences -relative<Cr>

nmap <buffer> K <Plug>(ale_documentation)
nmap <buffer> <Leader>af <Plug>(ale_lint)
nmap <buffer> <Leader>aF <Plug>(ale_fix)
nmap <buffer> <Leader>ai <Plug>(ale_import)
nmap <buffer> <Leader>aI :ALEOrganizeImports<Cr>
nmap <buffer> <Leader>ar <Plug>(ale_find_references)
nmap <buffer> <Leader>aR :ALERename<Cr>
