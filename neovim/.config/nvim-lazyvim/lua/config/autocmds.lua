-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_shank_" .. name, { clear = true })
end

-- obisidian
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("obsidian_open"),
  pattern = {
    "/home/shank/Sync/MyBrain/**.md",
  },
  callback = function()
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "ObsidianOpen" })
    vim.keymap.set("n", "<leader>on", ":ObsidianNew ", { desc = "ObsidianNew" })
    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "ObsidianSearch" })
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "ObsidianBacklinks" })
  end,
})

-- -- rust
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("rust-tools"),
--   pattern = "*.rs",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     vim.api.nvim_buf_set_keymap(
--       bufnr,
--       "n",
--       "<leader>K",
--       "<cmd>RustOpenExternalDocs<cr>",
--       { desc = "Rust - Open External Docs" }
--     )
--   end,
-- })

-- -- disable autoformat for python files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "python" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })
