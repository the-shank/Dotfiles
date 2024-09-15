-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- background
vim.opt.background = "light"

-- everforest theme : disable italic comment
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_background = "hard"

-- zenbones theme
-- vim.g.zenbones_compat = 1

-- disable swap
vim.opt.swapfile = false

-- conceal for obsidian links
-- source: https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#concealing-characters
vim.opt.conceallevel = 1
