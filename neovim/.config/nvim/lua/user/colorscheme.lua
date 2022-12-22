-- local colorscheme = "tokyonight-night"
-- vim.opt.background = "light"
vim.opt.background = "dark"
vim.g.everforest_background = "hard"
local colorscheme = "everforest"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
