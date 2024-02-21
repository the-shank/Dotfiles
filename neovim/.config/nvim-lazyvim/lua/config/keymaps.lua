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
end, { desc = "toggle light/dark theme" })

-- copilot enable
vim.keymap.set("n", "<leader>pe", function()
  vim.cmd("Copilot enable")
  print("Copilot enabled")
end, { desc = "Copilot enable" })

-- copilot disable
vim.keymap.set("n", "<leader>pd", function()
  vim.cmd("Copilot disable")
  print("Copilot disabled")
end, { desc = "Copilot disable" })

-- copilot status
vim.keymap.set("n", "<leader>ps", function()
  vim.cmd("Copilot status")
end, { desc = "Copilot status" })

-- Better paste
vim.keymap.set("v", "p", '"_dP')

-- center search results
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- copy path+line_num (for using in gdb)
vim.keymap.set("n", "<leader>yl", [[<cmd>let @+=expand("%:p").":".line(".")<cr>]], { desc = "yank <path>:<line_num>" })
