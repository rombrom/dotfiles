local function gobble(str, max, sep)
  max = max or 16
  sep = sep or '/'

  local path = vim.split(str, sep, { plain = true })
  local size = #path

  for i, segment in ipairs(path) do
    local length = #table.concat(path, sep)
    if i ~= size and length > max then
      path[i] = segment:match('^%.') and segment:sub(1, 2) or segment:sub(1, 1)
    end
  end

  return table.concat(path, sep)
end

_G.tabline = function()
  local prev_tab = vim.fn.tabpagenr('#')
  local result = ''

  for i = 1, vim.fn.tabpagenr('$') do
    local active = vim.fn.tabpagenr()
    local current = i

    local buflist = vim.fn.tabpagebuflist(current)
    local winnr = vim.fn.tabpagewinnr(current)
    local bufnr = buflist[winnr]
    local name = vim.fn.bufname(bufnr)

    result = result .. (active == current and '%#TabLineSel#' or '%#TabLine#')
    result = result .. '%' .. current .. 'T ' .. current .. ' '

    local marker = current == prev_tab and '#' or (active == current and '%%' or '')
    result = result .. marker .. ' '

    result = result .. (#name > 0 and gobble(name) or '[No Name]')
    result = result .. (vim.fn.getbufvar(bufnr, '&modified') == 1 and ' +' or '') .. ' '
  end

  result = result .. '%#TabLineFill#%T'

  return result
end

vim.o.tabline = '%!v:lua.tabline()'
