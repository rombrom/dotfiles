-- Prevent loading netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Prevent modeline execution
vim.opt.modeline = false

-- Editing
vim.opt.clipboard = 'unnamedplus'
vim.opt.complete:append 'kspell'
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'popup', 'fuzzy' }
vim.opt.dictionary:append '/usr/share/dict/words'
vim.opt.formatoptions:append 'n'
vim.opt.nrformats:append 'unsigned'
vim.opt.spelllang:append 'nl'

-- Indentation and wrapping
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
-- TODO
vim.cmd [[let &showbreak='› ']]

-- Search & tags
vim.opt.gdefault = true
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git' --ignore"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Terminal behavior
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.title = true
vim.opt.vb = true

-- UI
vim.opt.diffopt:append { 'algorithm:histogram', 'vertical' }
vim.opt.cursorlineopt = { 'screenline', 'number' }
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 10
vim.opt.list = true
vim.opt.listchars = { tab = '» ', extends = '›', precedes = '‹', nbsp = '·', trail = '·' }
vim.opt.scrolloff = 3
vim.opt.shortmess = 'atI'
vim.opt.showmatch = true
vim.opt.signcolumn = 'yes'
vim.opt.synmaxcol = 1000
vim.opt.termguicolors = true

-- Windows
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
vim.opt.winborder = "rounded"
vim.opt.winheight = 44
vim.opt.winminheight = 8
vim.opt.winminwidth = 8
vim.opt.winwidth = 88
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Experimental
vim.opt.sessionoptions = { 'buffers', 'folds', 'tabpages', 'winsize' }
vim.opt.wildoptions:append 'fuzzy'

-- Backup & undo
vim.opt.undofile = true -- persistent undo is AWESOME
vim.opt.updatetime = 1000

-- Leader setup
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\\\"

-- Diagnostics
vim.diagnostic.config({
  float = { border = 'rounded' },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '‼',
      [vim.diagnostic.severity.HINT] = '⏿',
      [vim.diagnostic.severity.INFO] = 'ℹ',
      [vim.diagnostic.severity.WARN] = '!',
    }
  },
  virtual_text = false,
})

