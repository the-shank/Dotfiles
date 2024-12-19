local Util = require("lazyvim.util")

local function my_pretty_path()
  return function()
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end

    local cwd = Util.root.cwd()

    -- vim.notify("cwd:" .. cwd)

    if path:sub(1, #cwd) == cwd then
      path = path:sub(#cwd + 2)
    end

    return path
  end
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = { my_pretty_path() },
      -- lualine_c = { "%f" },
    },
  },
}
