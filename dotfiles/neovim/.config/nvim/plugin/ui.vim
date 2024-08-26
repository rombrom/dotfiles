" I wanted to use `hi link` but this messes up the backgrounds 🤢
hi User1 ctermfg=1 ctermbg=0 cterm=bold guifg=#f55c45 guibg=#31373d gui=bold
hi User2 ctermfg=2 ctermbg=0 guifg=#afb833 guibg=#31373d
hi User3 ctermfg=3 ctermbg=0 cterm=bold guifg=#ebb242 guibg=#31373d gui=bold
hi User4 ctermfg=4 ctermbg=0 guifg=#5fb8b8 guibg=#31373d
hi User6 ctermfg=6 ctermbg=0 guifg=#6eb89f guibg=#31373d
hi User7 ctermfg=7 ctermbg=0 guifg=#9aaab8 guibg=#31373d
hi User8 ctermfg=none ctermbg=0 guifg=none guibg=#31373d
hi User9 ctermfg=12 ctermbg=0 cterm=bold guifg=#92d6d6 guibg=#31373d gui=bold

function ui#statusline() abort
  let statusline = ' %7*%n%* '

  " help/read only
  let statusline.= '%(%h%r %4*»%* %)'

  " filename
  let statusline.= '%(%4*»%* %8*%f%* %(%3*%M%* %)%)'
  let statusline.= '%(%{exists("w:quickfix_title") ? w:quickfix_title : ""} %)'

  " line/column number
  let statusline.= '%(%7*:%l,%c%V%* %)'

  " split
  let statusline.= '%='
  " cahracter below cursor: decimal, hex
  let statusline.= '%(%7*[%b/0x%B]%* %)'
  let statusline.= '%(%7*%P%* %)'        " percentage through file

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

  let statusline.= '%(%2*%{ALEProblems() == 0 ? "✓" : ""}%* %)'
  let statusline.= '%(%3*%{ALEProblems("warning", "style_warning")}!%* %)'
  let statusline.= '%(%1*%{ALEProblems("error", "style_error")}‼%* %)'

  " gutentags
  let statusline.= '%6*%{gutentags#statusline("", "", "♺ ")}%*'

  " branch name
  let statusline .= '%(%4*«%* %9*%<%{FugitiveHead(8)}%* %)'

  return statusline
endfunction

function ui#tabline() abort
  let prev_tab = tabpagenr('#')
  let tabline = ''

  for i in range(tabpagenr('$'))
    let active = tabpagenr()
    let current = i + 1

    let buflist = tabpagebuflist(current)
    let winnr = tabpagewinnr(current)
    let bufnr = buflist[winnr - 1]
    let name = bufname(bufnr)

    " select the highlighting
    let tabline .= active == current ? '%#TabLineSel#' : '%#TabLine#'
    " identify start of tab
    let tabline .= '%' . current . 'T ' . current . ' '

    " % = current buffer # = previous buffer
    let tabline .= (current == prev_tab ? '#' : active == current ? '%%' : '') . ' '
    " filename as t/r/.u/n/c/ated/filename.jpg
    " TODO: special buffers (no name, quickfix, etc.)
    let tabline .= (strlen(name) ? utils#gobble(name) : '[No Name]')
    " modified buffer or not
    let tabline .= (getbufvar(bufnr, '&modified') ? ' +' : '') . ' '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let tabline .= '%#TabLineFill#%T'

  return tabline
endfunction
