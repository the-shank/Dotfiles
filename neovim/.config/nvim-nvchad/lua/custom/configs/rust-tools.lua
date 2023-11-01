local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        -- for use in rustc_private projects
        rustc = {
          source = "discover"
        },
        -- enable clippy on save
        checkOnSave = {
          command = "clippy"
        }
      }
    },
  },
}

return options
