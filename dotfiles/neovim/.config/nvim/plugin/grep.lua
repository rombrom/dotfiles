local function grep(...)
  local args = type(...) == "string" and { vim.fn.shellescape(...) } or vim.iter(...).map(vim.fn.shellescape)

  vim.schedule(function()
    vim.cmd.grep {
      args = args,
      mods = { silent = true },
    }
  end)
end

_G.grep_operator = function(type)
  local saved = vim.fn.getreg('"')

  if type == "v" then
    vim.cmd('normal! `<v`>y')
  elseif type == "char" then
    vim.cmd('normal! `[v`]y')
  else
    return
  end

  local text = vim.fn.getreg('"')
  vim.fn.setreg('"', saved)

  grep(text)
end

vim.keymap.set('n', '<leader>g', function()
  vim.opt.operatorfunc = "v:lua.grep_operator"
  return "g@"
end, { expr = true })

vim.keymap.set("x", "<leader>g", function()
  -- We need to exit visual mode anyway
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  grep_operator(vim.fn.visualmode())
end, { silent = true })

vim.keymap.set('n', '<C-8>', function()
  grep(vim.fn.expand('<cword>'))
end, { expr = true })

vim.keymap.set('n', '<C-S-8>', function()
  grep(vim.fn.escape(vim.fn.expand('<cWORD>'), '\\/.*^~()[]?'))
end, { expr = true })
