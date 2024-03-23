local Util = require("lazyvim.util")

local function my_pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "MatchParen",
    directory_hl = "",
    filename_hl = "Bold",
    modified_sign = "",
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end

    local root = Util.root.get({ normalize = true })
    local cwd = Util.root.cwd()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    return path

    -- local sep = package.config:sub(1, 1)
    -- local parts = vim.split(path, "[\\/]")
    --
    -- if #parts > 3 then
    --   parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    -- end
    --
    -- if opts.modified_hl and vim.bo.modified then
    --   parts[#parts] = parts[#parts] .. opts.modified_sign
    --   parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
    -- else
    --   parts[#parts] = M.format(self, parts[#parts], opts.filename_hl)
    -- end
    --
    -- local dir = ""
    -- if #parts > 1 then
    --   dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
    --   dir = M.format(self, dir .. sep, opts.directory_hl)
    -- end
    -- return dir .. parts[#parts]
  end
end

local function my_root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = "󱉭 ",
    color = Util.ui.fg("Special"),
  }, opts or {})

  local function get()
    local cwd = Util.root.cwd()
    local root = Util.root.get({ normalize = true })
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    function()
      return (opts.icon and opts.icon .. " ") .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    color = opts.color,
  }
end

local icons = require("lazyvim.config").icons

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = {
        my_root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { my_pretty_path() },
      },
    },
  },
}
