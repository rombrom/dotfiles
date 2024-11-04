return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Individual test runners
    'marilari88/neotest-vitest'
  },

  keys = {
    { '<Leader>tt', '<Cmd>Neotest summary<Cr>' },
    { '<Leader>tr', '<Cmd>Neotest run<Cr>' },
    { '<Leader>tR', '<Cmd>Neotest run file<Cr>' },
    { '<Leader>to', '<Cmd>Neotest output-panel<Cr>' },
  },

  opts = function()
    return {
      adapters = {
        require 'neotest-vitest' {
          vitestCommand = 'npx vitest',
        },
      },
      highlights = {
        adapter_name = "Title",
        border = "FloatBorder",
        dir = "Directory",
        expand_marker = "FloatBorder",
        failed = "ErrorMsg",
        file = "Normal",
        focused = "MatchParen",
        indent = "FloatBorder",
        marked = "TextRedLight",
        namespace = "TextBlueLight",
        passed = "TextGreen",
        running = "TextYellow",
        select_win = "NeotestWinSelect",
        skipped = "Comment",
        target = "TextGreyLight",
        test = "Normal",
        unknown = "Comment",
        watching = "TextCyan"
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "✗",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        notify = "ℹ",
        passed = "✔",
        running = "⦿",
        running_animated = { "•", "⦿" },
        skipped = "╍",
        unknown = "•",
        watching = "⏿"
      },
    }
  end,
}
