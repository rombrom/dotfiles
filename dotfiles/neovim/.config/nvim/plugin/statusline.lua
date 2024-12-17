-- TODO: convert to neovim highlights
vim.cmd [[
  " I wanted to use `hi link` but this messes up the backgrounds 🤢
  hi User1 ctermfg=1 ctermbg=0 cterm=bold guifg=#f55c45 guibg=#31373d gui=bold
  hi User2 ctermfg=2 ctermbg=0 guifg=#afb833 guibg=#31373d
  hi User3 ctermfg=3 ctermbg=0 cterm=bold guifg=#ebb242 guibg=#31373d gui=bold
  hi User4 ctermfg=4 ctermbg=0 guifg=#5fb8b8 guibg=#31373d
  hi User6 ctermfg=6 ctermbg=0 guifg=#6eb89f guibg=#31373d
  hi User7 ctermfg=7 ctermbg=0 guifg=#9aaab8 guibg=#31373d
  hi User8 ctermfg=none ctermbg=0 guifg=none guibg=#31373d
  hi User9 ctermfg=12 ctermbg=0 cterm=bold guifg=#92d6d6 guibg=#31373d gui=bold
]]

local function get_diagnostics(buf)
  local result = { 0, 0, 0, 0 }

  for _, diagnostic in ipairs(vim.diagnostic.get(buf)) do
    result[diagnostic.severity] = result[diagnostic.severity] + 1
  end

  return {
    errors = result[vim.diagnostic.severity.ERROR],
    total = result[vim.diagnostic.severity.ERROR] + result[vim.diagnostic.severity.WARN],
    warnings = result[vim.diagnostic.severity.WARN],
  }
end

local function get_statusline(buf)
  local statusline = ''

  -- Buffer number
  statusline = statusline .. ' %7*%n%* '

  -- Help/Readonly indicator
  statusline = statusline .. '%(%h%r %4*»%* %)'

  -- Filename
  statusline = statusline .. '%(%4*»%* %8*%f%* %(%3*%M%* %)%)'
  statusline = statusline .. '%(%{exists("w:quickfix_title") ? w:quickfix_title : ""} %)'

  -- Line/column number
  statusline = statusline .. '%(%7*:%l,%c%V%* %)'

  -- Split
  statusline = statusline .. '%='

  -- Character below cursor: decimal, hex
  statusline = statusline .. '%(%7*[%b/0x%B]%* %)'

  -- Scroll indicator: % through file
  statusline = statusline .. '%(%7*%P%* %)'

  -- Diagnostics
  -- TODO: figure out why I cannot clear highlights with `%*`
  local diagnostics = get_diagnostics(buf or 0)
  if diagnostics.total == 0 then
    statusline = statusline .. '%(%2*✓ %)'
  else
    if diagnostics.warnings > 0 then
      statusline = statusline .. '%(%3*' .. diagnostics.warnings .. '! %)'
    end

    if diagnostics.errors > 0 then
      statusline = statusline .. '%(%1*' .. diagnostics.errors .. '‼ %)'
    end
  end

  -- Gutentags
  statusline = statusline .. '%6*%{gutentags#statusline("", "", "♺ ")}%*'

  -- Git branch
  statusline = statusline .. '%(%4*«%* %9*%<%{FugitiveHead(8)}%* %)'

  return statusline
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave', 'DiagnosticChanged', 'WinEnter', 'WinLeave' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('statusline', { clear = true }),
  callback = function(args)
    vim.opt_local.statusline = get_statusline(args.buf)
  end,
})

vim.opt.statusline = get_statusline()
