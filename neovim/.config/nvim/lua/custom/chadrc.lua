---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "everforest_light",
	theme_toggle = { "everforest_light", "everforest_light" },

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
			-- https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua#L200
			local st_modules = require("nvchad.statusline.default")

			-- [5] : file abspath + lsp progress
			local abspath = vim.fn.expand("%p")
			modules[5] = (function()
				return st_modules.LSP_progress() .. "%#St_file_txt#" .. abspath .. " "
			end)()

			-- [10] : cursor_position
			modules[10] = (function()
				return st_modules.cursor_position() .. " %#StText# %l:%02c "
			end)()
		end,
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
