function init#statusline() abort
  hi User1 ctermfg=1 ctermbg=0 cterm=bold
  hi User2 ctermfg=2 ctermbg=0
  hi User3 ctermfg=3 ctermbg=0 cterm=bold
  hi User4 ctermfg=4 ctermbg=0
  hi User7 ctermfg=7 ctermbg=0

  hi User8 ctermfg=none ctermbg=0
  hi User9 ctermfg=12 ctermbg=0 cterm=bold

  let statusline = ' %n '

  " help/read only
  let statusline.= '%(%h%r %4*»%* %)'

  " filename
  let statusline.= '%(%4*»%* %8*%f%* %(%3*%M%* %)%)'
  let statusline.= '%(%{exists("w:quickfix_title") ? w:quickfix_title : ""} %)'

  " line/column number
  let statusline.= '%(%7*:%l,%c%V%* %)'

  " split
  let statusline.= '%='
  let statusline.= '%( %7*%P%* %)'        " percentage through file

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

function init#tabline() abort
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
