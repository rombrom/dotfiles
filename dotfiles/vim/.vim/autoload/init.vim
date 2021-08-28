function! init#mkdirp(file, buf) abort
  if empty(getbufvar(a:buf, '&buftype')) && a:file !~# '\v^\w+\:\/'
    call mkdir(fnamemodify(a:file, ':h'), 'p')
  endif
endfunction

function init#statusline() abort
  hi User1 ctermfg=1 ctermbg=0 cterm=bold
  hi User2 ctermfg=2 ctermbg=0
  hi User3 ctermfg=3 ctermbg=0 cterm=bold
  hi User4 ctermfg=4 ctermbg=0
  hi User7 ctermfg=7 ctermbg=0

  hi User8 ctermfg=none ctermbg=0
  hi User9 ctermfg=12 ctermbg=0 cterm=bold

  let statusline = ' '

  " help/read only
  let statusline.= '%(%h%r %4*»%* %)'

  " filename
  let statusline.= '%(%8*%f%* %(%3*%M%* %)%)'
  let statusline.= '%(%{exists("w:quickfix_title") ? w:quickfix_title : ""} %)'

  " line/column number
  let statusline.= '%(%7*:%l,%c%V%* %)'

  " split
  let statusline.= '%='
  " let statusline.= '%( %7*%P%* %)'        " percentage through file

  " linter errors
  function! ALEProblems(...) abort
    " Earlier versions of vim do not have reduce() so we skip ALEProblems.
    " This is because opening prefs in Kitty terminal uses /usr/bin/vim.
    if !has("patch-8.2.0878")
      return ''
    endif

    let problems = ale#statusline#Count(bufnr())
    let total = 0

    if a:0 > 0
      let total = reduce(a:000, {acc, value
            \ -> acc + (has_key(problems, value) ? problems[value] : 0)
            \ }, total)
    else
      let total = reduce(values(problems), {acc, value -> acc + value}, total)
    endif

    return total == 0 ? '' : total
  endfunction

  let statusline.= '%(%2*%{ALEProblems() == 0 ? "✓" : ""} %*%)'
  let statusline.= '%(%3*%{ALEProblems("warning", "style_warning")}! %*%)'
  let statusline.= '%(%1*%{ALEProblems("error", "style_error")}‼ %*%)'

  " branch name
  let statusline .= '%(%4*«%* %9*%<%{FugitiveHead()}%* %)'

  " this makes sure the statusline is redrawn
  " :h stl-%{
  let &ro = &ro

  return statusline
endfunction

function init#webdev() abort
  " pretter formatter
  if executable('prettier')
    setlocal formatexpr=
    setlocal formatprg=prettier\ --stdin-filepath=%
  endif

  " mappings
  nmap <buffer> <Leader>dd <Plug>(ale_go_to_definition)
  nmap <buffer> <Leader>ds <Plug>(ale_go_to_definition_in_split)
  nmap <buffer> <Leader>dt <Plug>(ale_go_to_definition_in_tab)
  nmap <buffer> <Leader>dv <Plug>(ale_go_to_definition_in_vsplit)

  " add -relative option to find
  nnoremap <buffer> <silent> <Plug>(ale_find_references) :ALEFindReferences -relative<Cr>

  nmap <buffer> K <Plug>(ale_hover)
  nmap <buffer> <Leader>af <Plug>(ale_lint)
  nmap <buffer> <Leader>aF <Plug>(ale_fix)
  nmap <buffer> <Leader>ai <Plug>(ale_import)
  nmap <buffer> <Leader>aI :ALEOrganizeImports<Cr>
  nmap <buffer> <Leader>ar <Plug>(ale_find_references)
  nmap <buffer> <Leader>aR :ALERename<Cr>
endfunction
