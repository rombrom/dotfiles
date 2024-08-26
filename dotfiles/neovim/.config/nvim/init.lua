--
-- At some point it should be possible to eject from Packer and use Lazy
--
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local has_packer = ensure_packer()
local packer = require 'packer'

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- UI/UX & Workflow
  use 'ibhagwan/fzf-lua'

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require 'gitsigns'.setup() end
  }
  use 'ludovicchabant/vim-gutentags'
  use 'mattn/emmet-vim'
  use 'NvChad/nvim-colorizer.lua'
  use 'vim-test/vim-test'

  -- Langage support: linters, lsp, syntax
  use 'dense-analysis/ale'
  use 'neovim/nvim-lspconfig'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "nvim-treesitter/playground"

  -- Popie Jopie
  -- use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rsi'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'

  -- Not Popie Jopie
  use {
    'folke/zen-mode.nvim',
    config = function()
      require 'zen-mode'.setup({
        plugins = { kitty = { enabled = true } },
        window = { width = 80 },
      })
      vim.keymap.set('n', '<Leader>z', ':ZenMode<Cr>')
    end
  }
  use 'wellle/targets.vim'
  use {
    'echasnovski/mini.comment',
    config = function() require 'mini.comment'.setup() end
  }

  -- Theme
  use '~/Code/fansi2'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if has_packer then
    packer.sync()
  end
end)

-- Enables :Cfilter to filter quickfix entries
vim.cmd [[packadd! cfilter]]
