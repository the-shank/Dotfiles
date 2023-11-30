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

-- copilot (enable/disable)
vim.keymap.set("n", "<leader>pe", "<cmd> Copilot enable<CR>", { desc = "Copilot enable" })
vim.keymap.set("n", "<leader>pd", "<cmd> Copilot disable<CR>", { desc = "Copilot enable" })

-- Better paste
vim.keymap.set("v", "p", '"_dP')
