local grammars = {
  "bash",
  "comment", -- TODO, FIXME, etc.
  "css",
  "diff",
  "dockerfile",
  "embedded_template",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "liquid",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "regex",
  "ruby",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zsh",
}

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main"}
})

local treesitter = require("nvim-treesitter")
treesitter.install(grammars)

--
-- AUTOCOMMANDS
--
local qf_group = vim.api.nvim_create_augroup("treesitter", { clear = true })

-- Enable tree-sitter features for buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = grammars,
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
  end
})

-- Auto-update grammars when we change our pack config.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function() treesitter.update() end
})

