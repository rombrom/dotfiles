-- INSERT MODE
-- -----------
-- Sheesh. Neovim sends `CTRL-@` (:h i_CTRL-@) when pressing <C-Space>. Can't
-- repro this in vanilla vim, which inserts a space. It's annoying af when
-- doing fast completions. Just make it a regular space pls.
vim.keymap.set('i', '<C-Space>', '<Space>')

-- CTRL-U in insert mode deletes a lot. Put an undo-point before it.
vim.keymap.set('i', '<C-u>', '<C-g>u<C-u>')

-- auto-insert last spelling mistake in insert mode
vim.keymap.set('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')

-- NORMAL MODE
-- -----------
-- Move visually instead of by line
vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })

vim.keymap.set('n', '<Up>', function()
  return vim.v.count == 0 and 'g\\<Up>' or '<Up>'
end, { expr = true })

vim.keymap.set('n', '<Down>', function()
  return vim.v.count == 0 and 'g\\<Down>' or '<Down>'
end, { expr = true })

-- Y does the same as yy by default, instead of being consistent
-- with C, D (change/delete until end of line). I've began shooting
-- myself in the foot without this one.
vim.keymap.set('n', 'Y', 'y$')

-- Clear highlights in normal mode. After much fussing, C-c and Esc just seem
-- like a really intuitive bindings for this.
vim.keymap.set('n', '<C-c>', '<Cmd>noh<Cr>', { silent = true })
vim.keymap.set('n', '<Esc>', '<Cmd>noh<Cr>', { silent = true })

-- <Tab> advances through the jumplist, so <S-Tab> moves backwards
vim.keymap.set('n', '<S-Tab>', '<C-o>')

-- U to redo (I always found <C-r> unintuitive)
vim.keymap.set('n', 'U', '<C-r>')

-- make single quote work like backtick (e.g. go to column of mark, not
-- beginning of line)
vim.keymap.set('n', "'", '`', { remap = true })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
