-- These things always happen
vim.api.nvim_create_user_command('X', 'x', { bang = true })
vim.api.nvim_create_user_command('W', 'w', { bang = true })
vim.api.nvim_create_user_command('Q', 'q', { bang = true })
vim.api.nvim_create_user_command('Qa', 'qa', { bang = true })

