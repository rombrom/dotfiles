return {
  'ludovicchabant/vim-gutentags',

  init = function()
    vim.g.gutentags_file_list_command = {
      markers = { ['.git'] = 'git ls-files' }
    }

    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = { 'GutentagsUpdating', 'GutentagsUpdated' },
    --   -- TODO
    --   callback = function() vim.go.statusline = '%{ui#statusline()}' end,
    -- })
  end
}

