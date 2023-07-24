local ok, module = pcall(require, 'fzf-lua')

if not ok then
  print('Error loading "fzf-lua".')
  return
end

module.setup {
  actions = {
    files = {
      ["default"] = module.actions.file_edit_or_qf,
      ["ctrl-x"]  = module.actions.file_split,
      ["ctrl-v"]  = module.actions.file_vsplit,
      ["ctrl-t"]  = module.actions.file_tabedit,
      ["alt-q"]   = module.actions.file_sel_to_qf,
      ["alt-l"]   = module.actions.file_sel_to_ll,
    },
    buffers = {
      ["default"] = module.actions.buf_edit,
      ["ctrl-x"]  = module.actions.buf_split,
      ["ctrl-v"]  = module.actions.buf_vsplit,
      ["ctrl-t"]  = module.actions.buf_tabedit,
    }
  },
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
