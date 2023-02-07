-- vim.opt.background = "light"
vim.opt.background = "dark"

-- -- theme: everforest
-- vim.g.everforest_background = "hard"
-- vim.g.everforest_disable_italic_comment = 1
-- local colorscheme = "everforest"

-- theme: tokyonight
local colorscheme = "tokyonight-storm"
require("tokyonight").setup({
	style = "storm",
	light_style = "day", -- The theme is used when the background is set to light
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = false },
		keywords = { italic = false },
		functions = {},
		variables = {},
	},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
