vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })


vim.lsp.config("ruby_lsp", {
  init_options = {
    formatter = "standard",
    linters = { "standard" },
  }
})

vim.lsp.enable({
  "bashls",
  "cssls",
  "dockerls",
  "emmet_language_server",
  -- "herb_ls",
  "html",
  "postgres_lsp",
  "ruby_lsp",
  "shopify_theme_ls",
  "tailwindcss",
  "ts_ls",
})
