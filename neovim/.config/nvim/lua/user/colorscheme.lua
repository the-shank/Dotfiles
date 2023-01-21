-- vim.opt.background = "light"
vim.opt.background = "dark"

-- theme: everforest
vim.g.everforest_background = "hard"
vim.g.everforest_disable_italic_comment = 1
local colorscheme = "everforest"

-- theme: tokyonight
-- local colorscheme = "tokyonight-storm"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
