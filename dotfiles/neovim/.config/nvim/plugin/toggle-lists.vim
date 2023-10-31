" close lists quickly
function! GetBufferList() abort
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

" toggle quickfix/location lists easily
function! ToggleList(bufname, pfx) abort
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'c' && len(getqflist()) == 0
    echohl ErrorMsg | echo a:bufname." is Empty." | echohl None
    return
  endif
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg | echo a:bufname." is Empty." | echohl None
    return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> <Leader>q :call ToggleList("Quickfix List", 'c')<Cr>
nnoremap <silent> <Leader>l :call ToggleList("Location List", 'l')<Cr>

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
