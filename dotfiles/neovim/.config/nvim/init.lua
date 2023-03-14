vim.o.runtimepath = vim.env.HOME .. '/.vim,' .. vim.o.runtimepath .. ',' .. vim.env.HOME .. '/.vim/after'
vim.cmd('source ' .. vim.env.HOME .. '/.vim/vimrc')
