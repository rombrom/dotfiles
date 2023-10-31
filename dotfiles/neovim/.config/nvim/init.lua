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

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- UI/UX & Workflow
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require 'gitsigns'.setup() end
  }
  use 'ludovicchabant/vim-gutentags'
  use 'mattn/emmet-vim'
  use 'NvChad/nvim-colorizer.lua'

  use 'vim-test/vim-test'
  use 'wellle/targets.vim'

  -- Langage support: linters, lsp, syntax
  use 'dense-analysis/ale'
  use 'neovim/nvim-lspconfig'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function() require 'treesitter-context'.setup { separator = '─' } end,
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Not Popie Jopie
  use {
    'kylechui/nvim-surround',
    config = function() require 'nvim-surround'.setup() end,
    tag = '*'
  }

  -- Popie Jopie
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Enables :Cfilter to filter quickfix entries
vim.cmd [[packadd! cfilter]]
