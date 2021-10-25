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

" 'Gobbles' paths from:
" 'path/to/file.jpg' -> p/t/file.jgp
" 'path/to/extremely/.long/directory/path.png' -> p/t/e/.l/d/path.png
function! utils#gobble(str, max = 16, sep = '/') abort
  let path = split(a:str, a:sep)
  let size = len(path)

  for segment in path
    let index = index(path, segment)
    let length = strlen(join(path, a:sep))
    let path[index] =
          \ (index + 1) != size && length > a:max
          \ ? (segment =~ '^\.' ? segment[0:1] : segment[0:0])
          \ : segment
  endfor

  return join(path, a:sep)
endfunction
