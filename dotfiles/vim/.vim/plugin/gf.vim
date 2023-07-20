nnoremap <silent> gf :call <sid>openOrCreateFile()<CR>

function! s:openOrCreateFile() abort
  let l:path = expand('<cfile>')

  if empty(l:path)
    return
  endif

  try
    exe 'norm!gf'
  catch /.*/
    let l:new_path = fnamemodify(expand('%:p:h') . '/' . l:path, ':p')

    if !empty(fnamemodify(l:new_path, ':e'))
      return execute('edit '.l:new_path)
    endif

    let l:suffixes = split(&suffixesadd, ',')

    for l:suffix in l:suffixes
      if filereadable(l:new_path.l:suffix)
        return execute('edit '.l:new_path.l:suffix)
      endif
    endfor

    return execute('edit '.l:new_path.l:suffixes[0])
  endtry
endfunction
