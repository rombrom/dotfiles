-- Very awkward but using `vim.lsp.tagfunc` with `ruby-lsp` is inherently broken.
-- The ghetto solution is to use go to definition instead.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { buf = ev.buf })
  end,
})
