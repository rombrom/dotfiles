vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>dk', vim.diagnostic.open_float)
vim.keymap.set('n', '<Leader>dq', vim.diagnostic.setqflist)

-- Diagnostic trigger
-- TODO: this is pretty annoying...
-- local diagnostic = vim.api.nvim_create_augroup('diagnostic', { clear = true })
-- vim.api.nvim_create_autocmd('CursorHold', {
--   callback = function() vim.diagnostic.open_float() end,
--   group = diagnostic,
-- })
