vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({ "max-perf" })

vim.keymap.set("n", "<C-b>", fzf.buffers)
vim.keymap.set("n", "<C-g>", fzf.live_grep)
vim.keymap.set("n", "<C-p>", function()
  local clients = #vim.lsp.get_clients({ bufnnr = vim.api.nvim_get_current_buf() })

  if clients > 0 then
    fzf.lsp_workspace_symbols()
  else
    fzf.tags()
  end
end)
vim.keymap.set("n", "<C-p>", fzf.files)
