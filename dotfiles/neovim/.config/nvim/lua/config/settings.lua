-- Editing
vim.opt.autoread = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.clipboard = 'unnamed'
vim.opt.complete:append 'kspell'
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'preview' }
vim.opt.dictionary:append '/usr/share/dict/words'
vim.opt.formatoptions:append 'n'
vim.opt.nrformats:append 'unsigned'
vim.opt.spelllang:append 'nl'

-- Indentation and wrapping
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- TODO
vim.cmd [[let &showbreak='› ']]

-- Search & tags
vim.opt.gdefault = true
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case --hidden --glob '!.git' --ignore"
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
vim.opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic', 'vertical' }
vim.opt.cursorlineopt = { 'screenline', 'number' }
vim.opt.tabline = '%!ui#tabline()'
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

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true -- The same behavior as tmux
vim.opt.winheight = 44
vim.opt.winminheight = 8
vim.opt.winminwidth = 8
vim.opt.winwidth = 88

-- Experimental
vim.opt.sessionoptions = { 'buffers', 'folds', 'tabpages', 'winsize' }
vim.opt.wildignore = { '**/dist/**', '**/node_modules/**' }
vim.opt.wildoptions:append 'fuzzy'

-- Backup & undo
vim.opt.undofile = true -- persistent undo is AWESOME
vim.opt.updatetime = 1000

-- Theme
vim.opt.termguicolors = true
vim.cmd [[
  filetype plugin indent on
  syntax enable
]]

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -22

-- Leader setup
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\\\"

-- Diagnostics
vim.diagnostic.config({ virtual_text = false })
vim.fn.sign_define {
  { name = "DiagnosticSignError", text = "‼", texthl = "DiagnosticSignError" },
  { name = "DiagnosticSignHint", text = "⏿", texthl = "DiagnosticSignHint" },
  { name = "DiagnosticSignInfo", text = "ℹ", texthl = "DiagnosticSignInfo" },
  { name = "DiagnosticSignWarn", text = "!", texthl = "DiagnosticSignWarn" },
}
