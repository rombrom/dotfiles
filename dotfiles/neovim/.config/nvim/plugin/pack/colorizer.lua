vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })

require("colorizer").setup({
  options = {
    parsers = {
      css = true, -- preset: enables names, hex, rgb, hsl, oklch, css_var
      tailwind = {
        enable = true,
        update_names = true,
        lsp = true,
      },
      sass = {
        enable = true,
      },
      xterm = { enable = true }, -- xterm 256-color codes (#xNN, \e[38;5;NNNm)
    },
  }
})
