vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  columns = {
    "permissions",
    "size",
    "mtime",
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true
  }
})
