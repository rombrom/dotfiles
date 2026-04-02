local function toggle_list(bufname, pfx)
  -- Check if the list window is already open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.fn.getwininfo(win)[1][bufname] == 1 then
      vim.cmd(pfx .. "close")
      return
    end
  end

  -- Check if list is empty
  if pfx == "c" and #vim.fn.getqflist() == 0 then
    vim.notify(bufname .. " is Empty.", vim.log.levels.WARN)
    return
  end
  if pfx == "l" and #vim.fn.getloclist(0) == 0 then
    vim.notify(bufname .. " is Empty.", vim.log.levels.WARN)
    return
  end

  local winnr = vim.fn.winnr()
  vim.cmd(pfx .. "open")
  if vim.fn.winnr() ~= winnr then
    vim.cmd("wincmd p")
  end
end

vim.keymap.set("n", "<leader>q", function()
  toggle_list("quickfix", "c")
end, { silent = true })

vim.keymap.set("n", "<leader>l", function()
  toggle_list("loclist", "l")
end, { silent = true })

local qf_group = vim.api.nvim_create_augroup("quickfix", { clear = true })
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = qf_group,
  pattern = "cgetexpr",
  callback = function() vim.cmd("cwindow") end,
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = qf_group,
  pattern = "lgetexpr",
  callback = function() vim.cmd("lwindow") end,
})
