local vimrc = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  group = vimrc,
  command = [[
    if line("'\"") > 1 && line("'\"") <= line("$") |
      exe "normal! g'\" zz" |
    endif
  ]]
})

-- Create dir on save if it doesn't exist
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = vimrc,
  -- TODO: make this lua
  command = [[call utils#mkdirp(expand('<afile>'), +expand('<abuf>'))]]
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function() vim.diagnostic.open_float() end,
  group = vimrc,
})

-- Undo shell command errors
vim.api.nvim_create_autocmd('ShellFilterPost', {
  pattern = '*',
  group = vimrc,
  -- TODO: make this lua
  command = [[
    if v:shell_error
      undo
    endif
  ]]
})

-- Auto insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = vimrc,
  -- TODO: make this lua
  command = [[startinsert]]
})
