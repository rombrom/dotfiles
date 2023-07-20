" Plug 'prabirshrestha/vim-lsp'
" let g:lsp_document_code_action_signs_enabled = 0
" let g:lsp_document_highlight_enabled = 0
" let g:lsp_preview_doubletap = [function('lsp#ui#vim#output#closepreview')]
" let g:lsp_diagnostics_virtual_text_enabled = 0

" " There is a !@#$% annoying issue where mouse movement sends some escape
" " codes, completely borking scrolling, arrow keys and other things.
" " let g:lsp_hover_ui = 'preview'

" " Borrowed from: https://www.rockyourcode.com/use-vim-for-c-sharp-development-on-linux/
" " who borrowed from: https://hauleth.dev/post/vim-for-elixir/#completion-and-language-server
" function! s:enable_lsp(...) abort
"   let l:servers = lsp#get_whitelisted_servers()

"   for l:server in l:servers
"     let l:cap = lsp#get_server_capabilities(l:server)

"     if has_key(l:cap, 'hoverProvider')
"       setlocal keywordprg=:LspHover
"     endif

"     if has_key(l:cap, 'completionProvider')
"       setlocal omnifunc=lsp#complete
"     endif

"     if has_key(l:cap, 'definitionProvider') || has_key(l:cap, 'implementationProvider')
"       setlocal tagfunc=lsp#tagfunct
"     endif

"     if has_key(l:cap, 'definitionProvider')
"       nmap <silent> <buffer> <Leader>dd <Plug>(lsp-definition)
"       nmap <silent> <buffer> <Leader>ds :rightbelow :LspDefinition<Cr>
"       nmap <silent> <buffer> <Leader>dt :tab :LspDefinition<Cr>
"       nmap <silent> <buffer> <Leader>dv :vertical :LspDefinition<Cr>
"     endif

"     if has_key(l:cap, 'implementationProvider')
"       nmap <silent> <buffer> <Leader>ii <Plug>(lsp-implementation)
"       nmap <silent> <buffer> <Leader>is :rightbelow LspImplementation<Cr>
"       nmap <silent> <buffer> <Leader>it :tab LspImplementation<Cr>
"       nmap <silent> <buffer> <Leader>iv :vertical LspImplementation<Cr>
"     endif

"     if has_key(l:cap, 'referencesProvider')
"       nmap <silent> <buffer> <leader>gr <plug>(lsp-references)
"       nmap <silent> <buffer> ]r <plug>(lsp-next-reference)
"       nmap <silent> <buffer> [r <plug>(lsp-previous-reference)
"     endif

"     if has_key(l:cap, 'renameProvider')
"       nmap <silent> <buffer> <leader>gR <plug>(lsp-rename)
"     endif

"     for l:method in g:lsp_tagfunc_source_methods
"       if has_key(l:cap, l:method . 'Provider')
"         setlocal tagfunc=lsp#tagfunc
"       endif
"     endfor
"   endfor
" endfunction

" augroup lsp_install
"   autocmd!
"   autocmd User lsp_buffer_enabled call s:enable_lsp()
" augroup END
