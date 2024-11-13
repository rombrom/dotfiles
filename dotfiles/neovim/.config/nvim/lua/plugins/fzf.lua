return {
  'ibhagwan/fzf-lua',

  keys = function()
    local fzf = require('fzf-lua')
    return {
      { '<C-b>', fzf.buffers },
      { '<C-g>', fzf.live_grep },
      { '<C-o>', fzf.tags },
      { '<C-p>', fzf.files },
    }
  end,

  opts = function()
    local fzf = require('fzf-lua')
    return {
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
        bat = { args = '--color=always --style=changes' }
      },
      winopts = { backdrop = 100 },
    }
  end,
}
