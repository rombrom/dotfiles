-- INSERT MODE
-- -----------
-- Sheesh. Neovim sends `CTRL-@` (:h i_CTRL-@) when pressing <C-Space> in
-- insert mode. Can't repro this in vanilla vim, which inserts a space. It's
-- annoying af when doing fast completions. Just make it a regular space pls.
vim.keymap.set('i', '<C-Space>', '<Space>')

-- CTRL-U in insert mode deletes a lot. Put an undo-point before it.
vim.keymap.set('i', '<C-u>', '<C-g>u<C-u>')

-- auto-insert last spelling mistake in insert mode
vim.keymap.set('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')

-- NORMAL/VISUAL MODE
-- -----------
-- Move visually instead of by line and always center view.
vim.keymap.set({'n', 'v'}, 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set({'n', 'v'}, 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })

vim.keymap.set({'n', 'v'}, '<C-d>', '<C-d>zz')
vim.keymap.set({'n', 'v'}, '<C-u>', '<C-u>zz')

-- Copy filepath/line number
vim.keymap.set('n', '<Leader>y%', '<Cmd>let @*=join([expand("%"), line(".")], ":")<Cr>')

-- Y does the same as yy by default, instead of being consistent with C, D.
vim.keymap.set('n', 'Y', 'y$')

-- Clear highlights in normal mode. After much fussing, C-c and Esc just seem
-- like a really intuitive bindings for this.
vim.keymap.set('n', '<C-c>', '<Cmd>noh<Cr>', { silent = true })
vim.keymap.set('n', '<Esc>', '<Cmd>noh<Cr>', { silent = true })

-- <Tab> advances through the jumplist, so <S-Tab> moves backwards
vim.keymap.set('n', '<S-Tab>', '<C-o>')

-- U to redo
vim.keymap.set('n', 'U', '<C-r>')

-- Always use uppercase marks. They're more convenient.
for c = string.byte('a'), string.byte('z') do
  local lower = string.char(c)
  local upper = string.char(c - 32)
  vim.keymap.set('n', 'm' .. lower, 'm' .. upper, { noremap = true })
  vim.keymap.set('n', "'" .. lower, "'" .. upper, { noremap = true })
  vim.keymap.set('n', '`' .. lower, '`' .. upper, { noremap = true })
end

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Actual selection piping
-- As an example, when I use visual mode to select: 2 + 2, I can input `bc` and
-- the result will be output in the buffer in place of the selection.
vim.keymap.set('x', '!', function()
  local cmd = vim.fn.input('Filter command: ', '')
  if cmd == '' then return end
  cmd = vim.fn.escape(cmd, [[\']]) -- escape single quote/backslash for the command string
  vim.cmd(string.format("'<,'>s/\\%%V.\\+/\\=join(systemlist('%s', submatch(0)), \"\\n\")/e", cmd))
end, { noremap = true, silent = true })
