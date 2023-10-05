---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "everforest_light",
	theme_toggle = { "everforest_light", "everforest" },

	hl_override = highlights.override,
	hl_add = highlights.add,

	nvdash = {
		load_on_startup = true,
		header = {
			"███████ ██   ██  █████  ███    ██ ██   ██",
			"██      ██   ██ ██   ██ ████   ██ ██  ██ ",
			"███████ ███████ ███████ ██ ██  ██ █████  ",
			"     ██ ██   ██ ██   ██ ██  ██ ██ ██  ██ ",
			"███████ ██   ██ ██   ██ ██   ████ ██   ██",
		},
	},

	cheatsheet = {
		theme = "simple",
	},

	telescope = {
		style = "bordered",
	},


	statusline = {
		overriden_modules = function(modules)
			-- for module indexes, see
			-- https://github.com/NvChad/ui/blob/4c00182f728ad565b1140ca95b802bd24860965f/lua/nvchad/statusline/default.lua#L185
			-- [2] : fileinfo
			local st_modules = require("nvchad.statusline.default")
			local abspath = vim.fn.expand("%p")
			modules[2] = (function()
				return st_modules.fileInfo() .. "%#St_file_txt#" .. abspath .. " "
			end)()

			-- [8] : cursor_position
			modules[8] = (function()
				return "%#StText# %l:%c "
			end)()
		end,
	},

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
