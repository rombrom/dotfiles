" Use <!-- --> comments in HTML
let html_wrong_comments = 1

" fix indenting of css/js syntax in script/style tags
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

augroup MyHTML
  " fix common syntax highlighting issues in html files
  au BufNewFile,BufRead *.html,*.svelte syntax sync fromstart
augroup END

if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif
