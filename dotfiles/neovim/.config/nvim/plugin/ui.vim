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
