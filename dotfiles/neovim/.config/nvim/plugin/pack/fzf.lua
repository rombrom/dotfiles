vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
  "max-perf",

  git = {
    status = {
      preview_pager = false
    }
  }
})

vim.keymap.set("n", "<C-b>", fzf.buffers)
vim.keymap.set("n", "<C-f>", fzf.live_grep)
vim.keymap.set("n", "<C-g>", fzf.git_status)
vim.keymap.set("n", "<C-t>", fzf.tags)
vim.keymap.set("n", "<C-p>", fzf.files)
