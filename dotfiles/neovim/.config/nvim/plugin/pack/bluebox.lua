local local_repo = vim.fn.expand("$HOME") .. "/Code/fansi2"
local uri = vim.fn.isdirectory(local_repo) and local_repo or "https://github.com/rombrom/fansi2"

vim.pack.add({ uri })
vim.cmd.colorscheme("fansi2")
