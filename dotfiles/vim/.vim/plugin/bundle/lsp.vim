" Plug 'prabirshrestha/vim-lsp'
let g:lsp_document_code_action_signs_enabled = 0

" Borrowed from: https://www.rockyourcode.com/use-vim-for-c-sharp-development-on-linux/
" who borrowed from: https://hauleth.dev/post/vim-for-elixir/#completion-and-language-server
function! s:enable_lsp(...) abort
  let l:servers = lsp#get_whitelisted_servers()

  for l:server in l:servers
    let l:cap = lsp#get_server_capabilities(l:server)

    if has_key(l:cap, 'completionProvider')
      setlocal omnifunc=lsp#complete
    endif

    if has_key(l:cap, 'hoverProvider')
      setlocal keywordprg=:LspHover
    endif

    if has_key(l:cap, 'definitionProvider')
      nmap <silent> <buffer> gd <plug>(lsp-definition)
      nmap <silent> <buffer> <Leader>dd <Plug>(lsp-definition)
      nmap <silent> <buffer> <Leader>ds :rightbelow LspDefinition<Cr>
      nmap <silent> <buffer> <Leader>dt :tab LspDefinition<Cr>
      nmap <silent> <buffer> <Leader>dv :vertical LspDefinition<Cr>
    endif

    if has_key(l:cap, 'referencesProvider')
      nmap <silent> <buffer> <leader>gr <plug>(lsp-references)
      nmap <silent> <buffer> ]r <plug>(lsp-next-reference)
      nmap <silent> <buffer> [r <plug>(lsp-previous-reference)
    endif

    if has_key(l:cap, 'renameProvider')
      nmap <silent> <buffer> <leader>gR <plug>(lsp-rename)
    endif
  endfor
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:enable_lsp()
augroup END
