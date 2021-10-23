" gets the target of a visual selection or grammar object
function! utils#getTarget(type) abort
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  return utils#EscapeRegExp(@@)
endfunction
~
" auto create subfolders like mkdir -p
function! utils#mkdirp(file, buf) abort
  if empty(getbufvar(a:buf, '&buftype')) && a:file !~# '\v^\w+\:\/'
    call mkdir(fnamemodify(a:file, ':h'), 'p')
  endif
endfunction


" escape regular expression tokens for ripgrep
" there are some issues with this still, I think.
function! utils#EscapeRegExp(str) abort
  " this sick boi escapes regexp special characters
  return substitute(escape(trim(a:str), '[]{}().+*?\|^$'), '\\', '\\\\\\\\\', 'g')
endfunction
