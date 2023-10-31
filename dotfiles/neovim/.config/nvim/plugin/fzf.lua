vim.g.fzf_buffers_jump = 1
vim.g.fzf_tags_command = 'ctag -R --tag-relative'

vim.keymap.set('n', '<C-b>', ':Buffers<Cr>')
vim.keymap.set('n', '<C-g>', ':Rg<Cr>')
vim.keymap.set('n', '<C-o>', ':Tags<Cr>')
vim.keymap.set('n', '<C-p>', ':Files<Cr>')
