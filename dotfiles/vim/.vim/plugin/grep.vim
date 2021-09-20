"F let :grep work without suspending vim, executing in the background
" and open the quickfix/location list automatically.
" See: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
" Sorry for copying, romainl, your snippet is almost perfect.
function! Grep(...) abort
  " expandcmd removes backslashes somehow... we could:
  return system(join([&grepprg] + [a:1] + [expandcmd(join(a:000[1:-1], ' '))], ' '))
endfunction

function! EscapeRegExp(str) abort
  " this sick boi escapes regexp special characters
  return substitute(escape(trim(a:str), '[]{}().+*?\|^$'), '\\', '\\\\\\\\\', 'g')
endfunction

function! GrepOperator(type) abort
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  let pattern = EscapeRegExp(@@)

  " TODO: figure this out; why does checking for space work?
  silent execute 'Grep ' . (stridx(pattern, ' ') > 0 ? shellescape(pattern) : pattern)
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

nnoremap <silent> <Leader>g :set operatorfunc=GrepOperator<Cr>g@
vnoremap <silent> <Leader>g :<C-u>call GrepOperator(visualmode())<Cr>
nnoremap <silent> <Leader>gg :Grep <C-r>=EscapeRegExp(expand('<cword>'))<Cr><Cr>
nnoremap <silent> <Leader>gG :Grep <C-r>=EscapeRegExp(expand('<cWORD>'))<Cr><Cr>
