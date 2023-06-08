local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- set rulers
opt.colorcolumn = { 100, 120 }

-- navigate help text using <CR> to go to item under cursor
autocmd({ "FileType" }, {
  pattern = { "help" },
  callback = function()
    vim.cmd [[ nnoremap <buffer> <CR> <C-]> ]]
  end,
})
