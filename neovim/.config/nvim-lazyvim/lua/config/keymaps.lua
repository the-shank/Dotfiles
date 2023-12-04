-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- toggle background (light/dark)
vim.keymap.set("n", "<leader>tt", function()
  local current_bg = vim.o.background
  if current_bg == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end)

-- copilot
vim.keymap.set("n", "<leader>pe", function()
  vim.cmd("Copilot enable")
  print("Copilot enabled")
end, { desc = "Copilot enable" })

vim.keymap.set("n", "<leader>pd", function()
  vim.cmd("Copilot disable")
  print("Copilot disabled")
end, { desc = "Copilot enable" })

vim.keymap.set("n", "<leader>ps", function()
  vim.cmd("Copilot status")
end, { desc = "Copilot status" })

-- Better paste
vim.keymap.set("v", "p", '"_dP')
