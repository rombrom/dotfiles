local function toggle_list(bufname, pfx)
  -- Check if the list window is already open
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if buf.name:match(bufname) then
      if vim.fn.bufwinnr(buf.bufnr) ~= -1 then
        vim.cmd(pfx .. "close")
        return
      end
    end
  end

  -- Check if list is empty
  if pfx == "c" and #vim.fn.getqflist() == 0 then
    vim.notify(bufname .. " is Empty.", vim.log.levels.ERROR)
    return
  end
  if pfx == "l" and #vim.fn.getloclist(0) == 0 then
    vim.notify(bufname .. " is Empty.", vim.log.levels.ERROR)
    return
  end

  local winnr = vim.fn.winnr()
  vim.cmd(pfx .. "open")
  if vim.fn.winnr() ~= winnr then
    vim.cmd("wincmd p")
  end
end

vim.keymap.set("n", "<leader>q", function()
  toggle_list("Quickfix List", "c")
end, { silent = true })

vim.keymap.set("n", "<leader>l", function()
  toggle_list("Location List", "l")
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
