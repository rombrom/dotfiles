return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    adapters = {
      http = {
        llama_cpp = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://127.0.0.1:8080",
              api_key = "flapdrol",
            },
          })
        end,
      }
    },
    strategies = {
      chat = {
        adapter = "llama_cpp",
      },
      inline = {
        adapter = "llama_cpp",
      },
      cmd = {
        adapter = "llama_cpp",
      }
    },
  }
}
