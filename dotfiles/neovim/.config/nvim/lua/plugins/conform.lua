local prettier = { "prettier", stop_after_first = true }

return {
  'stevearc/conform.nvim',

  init = function()
    vim.api.nvim_create_user_command("ConformDisable", function(args)
      local scope = args.bang and 'g' or 'b'
      vim[scope].disable_autoformat = true
    end, {
      bang = true,
      desc = "Disable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("ConformEnable", function(args)
      local scope = args.bang and 'g' or 'b'
      -- always enable on the buffer
      vim.b.disable_autoformat = false
      vim[scope].disable_autoformat = false
    end, {
      bang = true,
      desc = "Enable autoformat-on-save",
    })
  end,

  keys = function()
    local conform = require('conform')
    return {
      { '<Leader>=', conform.format }
    }
  end,

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 500 }
    end,
    formatters_by_ft = {
      css = prettier,
      graphql = prettier,
      html = prettier,
      javascript = prettier,
      javascriptreact = prettier,
      json = prettier,
      less = prettier,
      lua = { "stylua" },
      markdown = prettier,
      python = function(bufnr)
        if require 'conform'.get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,
      rust = { "rustfmt" },
      scss = prettier,
      svelte = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      vue = prettier,
      yaml = prettier,
    }
  },
}
