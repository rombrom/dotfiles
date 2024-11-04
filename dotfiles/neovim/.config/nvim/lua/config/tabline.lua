-- TODO
local function set_tabline()
  local tabline = ''

  local active = vim.fn.tabpagenr()
  local prev = vim.fn.tabpagenr('#')

  for current = 1, vim.fn.tabpagenr('$') + 1 do
    local buflist = vim.fn.tabpagebuflist(current)
    local winnr = vim.fn.tabpagewinnr(current)
    local bufnr = buflist ~= 0 and buflist[winnr - 1] or 0
    local name = bufnr and vim.fn.bufname(bufnr) or vim.fn.bufname()
    local modified = vim.fn.getbufvar(bufnr, '&modified')

    tabline = tabline .. current == active and '%#TabLineSel#' or '%#TabLine#'
    tabline = tabline .. '%' .. current .. 'T' .. current .. ' '

    if current == active then
      tabline = tabline .. '%% '
    elseif current == prev then
      tabline = tabline .. '# '
    end

    -- TODO: gobble
    tabline = tabline .. #name and name or '[No Name]'

    -- Modified
    tabline = tabline .. modified and ' + ' or ' '
  end

  tabline = tabline .. '%#TabLineFill%T'

  vim.opt.tabline = tabline
end

set_tabline()
