vim.pack.add({
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/tpope/vim-fugitive",
})

require("mini.diff").setup({
  view = {
    signs = { add = '+', change = '~', delete = '-' }
  }
})
