local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- set rulers
opt.colorcolumn = { 100, 120 }

-- dont create backup files or swapfiles
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- utf-8 fileencoding
opt.fileencoding = "utf-8"

-- highlight the current cursor line
opt.cursorline = true

-- keep a few lines above and below the curor
opt.scrolloff = 3
opt.sidescrolloff = 8

-- navigate help text using <CR> to go to item under cursor
autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("ShankNavigateHelp", { clear = true }),
	pattern = { "help" },
	callback = function()
		vim.cmd([[ nnoremap <buffer> <CR> <C-]> ]])
	end,
})

-- highlight on yank
autocmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("ShankHighlightYank", { clear = true }),
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank()
	end,
})
