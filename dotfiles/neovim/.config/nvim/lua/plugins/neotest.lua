return {
  "nvim-neotest/neotest",

  opt = {
    adapters = {
      ['neotest-vitest'] = {}
    }
  },

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Individual test runners
    'marilari88/neotest-vitest'
  }
}
