local ok, module = pcall(require, 'cmp')

if not ok then
  print('Error loading "cmp".')
  return
end

module.setup {
  completion = {
    enabled = false
  },
  mapping = module.mapping.preset.insert({
    ['<C-b>'] = module.mapping.scroll_docs(-4),
    ['<C-f>'] = module.mapping.scroll_docs(4),
    ['<C-Space>'] = module.mapping.complete(),
    ['<C-e>'] = module.mapping.abort(),
    ['<Cr>'] = module.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
  },
  sources = module.config.sources({
    { name = 'nvim_lsp' },
    {
      name = 'buffer',
      options = {
        get_bufnrs = vim.api.nvim_list_bufs,
        keyword_pattern = [[\k\+]],
      }
    },
  }),
  window = {
    documentation = module.config.window.bordered()
  },
}
