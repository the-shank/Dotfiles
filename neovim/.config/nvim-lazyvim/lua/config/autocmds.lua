-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_shank_" .. name, { clear = true })
end

-- obisidian open
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("obsidian_open"),
  pattern = {
    "/home/shank/Sync/MyBrain/**.md",
    "/home/shank/Downloads/tmp-vault/**.md",
  },
  callback = function()
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>")
    vim.keymap.set("n", "<leader>on", ":ObsidianNew ")
    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>")
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>")
  end,
})
