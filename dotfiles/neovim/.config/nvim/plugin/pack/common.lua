vim.cmd.packadd("cfilter")

vim.pack.add({
  "https://github.com/nvim-mini/mini.move",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-rsi",
})

require("mini.move").setup()
require("mini.surround").setup()
