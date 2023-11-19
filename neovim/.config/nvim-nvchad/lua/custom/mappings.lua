---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-Up>"] = { "<cmd> resize -1 <CR>", "increase size up", opts = { nowait = true } },
		["<C-Down>"] = { "<cmd> resize +1 <CR>", "increase size down", opts = { nowait = true } },
		["<C-Left>"] = { "<cmd> vertical resize -1 <CR>", "increase size left", opts = { nowait = true } },
		["<C-Right>"] = { "<cmd> vertical resize +1 <CR>", "increase size right", opts = { nowait = true } },

		-- center search results
		["n"] = { "nzz", "next", opts = { nowait = true } },
		["N"] = { "Nzz", "previous", opts = { nowait = true } },
		["*"] = { "*zz", "next", opts = { nowait = true } },
		["#"] = { "#zz", "next", opts = { nowait = true } },

		-- previous buffer
		["<leader><tab>"] = { "<C-^><CR>", "switch to previous buffer", opts = { nowait = true } },
	},

	v = {
		["<"] = { "<gv", "indent left", opts = { nowait = true } },
		[">"] = { ">gv", "indent left", opts = { nowait = true } },
	},
}

-- more keybinds!

M.telescope = {
	n = {
		["<leader>ff"] = {
			"<cmd> Telescope find_files theme=get_dropdown previewer=false find_command=bfs,-type,f,-follow,-not,-path,target/,-not,-path,.git/,-not,-path,.cache/ <CR>",
			"Find files",
		},
		["<leader>fF"] = {
			"<cmd> Telescope find_files theme=get_dropdown previewer=false find_command=bfs,-type,f,-follow,-maxdepth,3,-not,-path,target/,-not,-path,.git/,-not,-path,.cache/ <CR>",
			"Find shallow",
		},
		["<leader>fa"] = {
			"<cmd> Telescope find_files theme=get_dropdown previewer=false follow=true no_ignore=true hidden=true <CR>",
			"Find all",
		},
		-- ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true ignore-case exclude=target/ exclude=.git/ exclude=.cache/ <CR>", "Find all" },
		["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Document Symbols" },
		["<leader>fS"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "Workspace Symbols" },
		["<leader>'"] = { "<cmd> Telescope resume <CR>", "Resume Picker" },
	},
}

M.symbols_outline = {
	n = {
		["<leader>o"] = { "<cmd> SymbolsOutline <CR>" },
	},
}

M.lspconfig = {
	n = {
		["gD"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP type definition",
		},

		["<leader>d"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"Floating diagnostic",
		},
	},
}

return M
