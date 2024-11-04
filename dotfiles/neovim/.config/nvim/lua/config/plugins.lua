-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  checker = { enabled = true },
  dev = { path = '~/Code' },
  spec = {
    -- -- Plugins without config
    'tpope/vim-dispatch',   -- Dispatch to terminal stuff
    'tpope/vim-eunuch',     -- UNIX util commands, :Rename, :Move, :Delete
    'tpope/vim-fugitive',   -- Amazing git porcelain
    'tpope/vim-obsession',  -- Persistent sessions
    'tpope/vim-repeat',     -- I mean, it repeats things with .
    'tpope/vim-rsi',        -- Readline mappings in insert mode and shit
    'tpope/vim-unimpaired', -- Extra mappings on ][
    --
    -- -- Elaborate plugins
    { import = "plugins" }
  },
  ui = { border = 'rounded' },
})
