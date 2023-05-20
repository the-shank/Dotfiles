---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-Up>"] = { "<cmd> resize -1 <CR>", "increase size up", opts = { nowait = true } },
    ["<C-Down>"] = { "<cmd> resize +1 <CR>", "increase size down", opts = { nowait = true } },
    ["<C-Left>"] = { "<cmd> vertical resize -1 <CR>", "increase size left", opts = { nowait = true } },
    ["<C-Right>"] = { "<cmd> vertical resize +1 <CR>", "increase size right", opts = { nowait = true } },
  },
}

-- more keybinds!

M.telescope = {
  n = {
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    -- ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true ignore-case exclude=target/ exclude=.git/ exclude=.cache/ <CR>", "Find all" },
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Document Symbols"},
    ["<leader>fS"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "Workspace Symbols"},
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
  }
}

return M
