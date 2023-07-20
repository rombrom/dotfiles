--
-- At some point it should be possible to eject from Packer and use Lazy
--
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- nvim
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- UX/UI
  use { vim.env.HOMEBREW_PREFIX .. "/opt/fzf" }
  use "junegunn/fzf.vim"
  use "airblade/vim-gitgutter"
  use "editorconfig/editorconfig-vim"
  use "ludovicchabant/vim-gutentags"
  use "mattn/emmet-vim"
  use "vim-test/vim-test"
  use "wellle/targets.vim"

  -- Theme debugging
  -- "gerw/vim-HiLinkTrace"

  -- Langage support: linters lsp syntax
  use "dense-analysis/ale"
  use "neovim/nvim-lspconfig"
  -- use "prabirshrestha/vim-lsp"
  -- use "rhysd/vim-lsp-ale"
  -- use "mattn/vim-lsp-settings"
  use "sheerun/vim-polyglot"

  -- Popie Jopie
  use "tpope/vim-commentary"
  use "tpope/vim-dispatch"
  use "tpope/vim-eunuch"
  use "tpope/vim-fugitive"
  use "tpope/vim-obsession"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
