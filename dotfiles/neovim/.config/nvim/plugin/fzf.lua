local fzf = require('fzf-lua');

fzf.setup({
  'max-perf',

  actions = {
    files = {
      true, -- inherit from defaults (:h fzf-lua-default-options)
      ["ctrl-s"] = false,
      ["ctrl-x"] = fzf.actions.file_split,
    },
    buffers = {
      true, -- inherit from defaults (:h fzf-lua-default-options)
      ["ctrl-s"] = false,
      ["ctrl-x"] = fzf.actions.buf_split,
    }
  },

  defaults = { header = false },

  previewers = {
    bat = {
      args = '--color=always --style=changes'
    }
  },

  winopts = {
    backdrop = 100,
  },
})

vim.g.fzf_buffers_jump = 1
-- vim.g.fzf_tags_command = 'ctag -R --tag-relative'

vim.keymap.set('n', '<C-b>', fzf.buffers)
vim.keymap.set('n', '<C-g>', fzf.live_grep)
vim.keymap.set('n', '<C-o>', fzf.tags)
vim.keymap.set('n', '<C-p>', fzf.files)
