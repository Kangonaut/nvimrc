vim.notify("This is a test", "info")

-- toggle relative line numbers
vim.keymap.set("n", "<leader>tl", function()
  -- toggle option
  local is_enabled = vim.opt_local.relativenumber:get()
  vim.opt_local.relativenumber = not is_enabled

  -- notification message
  if is_enabled then
    vim.notify("disabled relative line numbers")
  else
    vim.notify("enabled relative line numbers")
  end
end, { desc = "[l]ine numbers" })
