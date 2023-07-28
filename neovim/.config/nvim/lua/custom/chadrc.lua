---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "everforest_light",
  theme_toggle = { "everforest_light", "everforest_light_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
    header = {
      "███████ ██   ██  █████  ███    ██ ██   ██",
      "██      ██   ██ ██   ██ ████   ██ ██  ██ ",
      "███████ ███████ ███████ ██ ██  ██ █████  ",
      "     ██ ██   ██ ██   ██ ██  ██ ██ ██  ██ ",
      "███████ ██   ██ ██   ██ ██   ████ ██   ██",
    },
  },

  cheatsheet = {
    theme = "simple",
  },

  telescope = {
    style = "bordered",
  },

  statusline = {
    overriden_modules = function()
      local st_modules = require "nvchad_ui.statusline.default"
      local abspath = vim.fn.expand "%p"

      return {
        fileInfo = function()
          return st_modules.fileInfo() .. "%#St_file_txt#" .. abspath .. " "
        end,

        cursor_position = function()
          return "%#StText# %l:%c "
        end,
      }
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
