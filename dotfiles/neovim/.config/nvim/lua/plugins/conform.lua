local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  'stevearc/conform.nvim',
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
    },
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
      python = { "isort", "black", "ruff" },
      rust = { "rustfmt" },
      scss = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      vue = prettier,
      yaml = prettier,
    }
  },

  keys = function()
    local conform = require('conform')
    return {
      { '<Leader>=', conform.format }
    }
  end
}
