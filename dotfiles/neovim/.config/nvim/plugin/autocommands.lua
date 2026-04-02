local vimrc = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  group = vimrc,
  callback = function()
    local line_num = vim.fn.line("'\"")
    if line_num > 1 and line_num <= vim.fn.line('$') then
      vim.cmd('normal! g\'" zz')
    end
  end
})

-- Create dir on save if it doesn't exist
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = vimrc,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 1 then return end
    vim.fn.mkdir(dir, 'p')
  end
})

-- Undo shell command errors
vim.api.nvim_create_autocmd('ShellFilterPost', {
  pattern = '*',
  group = vimrc,
  callback = function()
    if vim.v.shell_error == 0 then return end
    vim.cmd.undo()
  end
})

-- Auto insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = vimrc,
  callback = function() vim.cmd.startinsert() end
})

