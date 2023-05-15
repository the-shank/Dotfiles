---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

M.telescope = {
  n = {
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    -- ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true ignore-case exclude=target/ exclude=.git/ exclude=.cache/ <CR>", "Find all" },
    ["<leader>s"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Document Symbols"},
    ["<leader>S"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "Workspace Symbols"},
  },
}

M.symbols_outline = {
  n = {
    ["<leader>o"] = { "<cmd> SymbolsOutline <CR>" },
  },
}

return M
