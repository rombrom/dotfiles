local ok, module = pcall(require, 'fzf-lua')

if not ok then
  print('Error loading "fzf-lua".')
  return
end

module.setup {
  winopts = {
    preview = {
      winopts = {
        number = false
      }
    }
  }
}

vim.keymap.set('n', '<C-b>', module.buffers)
vim.keymap.set('n', '<C-f>', module.lsp_finder)
vim.keymap.set('n', '<C-g>', module.grep_project)
vim.keymap.set('n', '<C-o>', module.tags)
vim.keymap.set('n', '<C-p>', module.files)
