local M = {}

M.treesitter = {
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"css",
		"dockerfile",
		"html",
		"javascript",
		"llvm",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"solidity",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",

		-- rust
		"rust-analyzer",

		-- python
		"pyright",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
		ignore = false,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},

	actions = {
		open_file = {
			resize_window = false,
		},
	},
}

return M
