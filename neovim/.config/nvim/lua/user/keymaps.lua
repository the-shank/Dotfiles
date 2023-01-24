-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap(
	"n",
	"<leader>ff",
	":Telescope find_files find_command=fd,--hidden,--ignore-case,--follow,--strip-cwd-prefix,--no-ignore-vcs,--exclude,target/,--exclude,.git/,--exclude,.cache/<CR>",
	opts
)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers sort_mru=true<CR>", opts)
keymap("n", "<leader>fo", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fO", ":Telescope lsp_dynamic_workspace_symbols<CR>", opts)
keymap("n", "<leader>fO", ":Telescope lsp_dynamic_workspace_symbols<CR>", opts)
keymap("n", "<leader>c", ":Telescope commands<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("v", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

-- Tagbar
-- keymap("n", "<leader>to", "<cmd>TagbarOpen fj<cr>", opts)
-- keymap("n", "<leader>tq", "<cmd>TagbarClose<cr>", opts)

-- Symbols Outline (replacing tagbar for me)
keymap("n", "<leader>o", "<cmd>SymbolsOutline<cr>", opts)

-- Harpoon
keymap("n", "<leader>ma", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "<leader>ml", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)

-- reload colorscheme
keymap("n", "<leader>C", ":source ~/.config/nvim/lua/user/colorscheme.lua<cr>", opts)

-- toggle quickfix list
-- ref: https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/keymaps.lua
vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])
keymap("n", "<M-q>", ":call QuickFixToggle()<cr>", opts)

-- quick save, quick quit
keymap("n", "<leader>w", ":w<cr>", opts)
-- keymap("n", ";q", ":q<cr>", opts) -- disabled since it introduces delay in repeat action (;)

-- vsplit
keymap("n", "<leader>v", ":vsplit<cr>", opts)

-- center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
-- keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>ld", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
keymap("n", "<leader>tt", "<cmd>TodoTrouble<cr>", opts)

-- Bufferline
keymap("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", opts)
