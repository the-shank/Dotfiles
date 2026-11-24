local function blend_50(fg, bg)
  local r1, g1, b1 = tonumber(fg:sub(2, 3), 16), tonumber(fg:sub(4, 5), 16), tonumber(fg:sub(6, 7), 16)
  local r2, g2, b2 = tonumber(bg:sub(2, 3), 16), tonumber(bg:sub(4, 5), 16), tonumber(bg:sub(6, 7), 16)
  return string.format(
    "#%02x%02x%02x",
    math.floor((r1 + r2) / 2 + 0.5),
    math.floor((g1 + g2) / 2 + 0.5),
    math.floor((b1 + b2) / 2 + 0.5)
  )
end

return {
  "folke/tokyonight.nvim",
  opts = {
    styles = {
      comments = {
        italic = false,
      },
      keywords = {
        italic = false,
      },
    },
    on_colors = function(c)
      if vim.o.background == "light" then
        c.bg = "#eef0f4"
        c.bg_dark = "#dfe1e7"
        c.bg_highlight = "#e4e6eb"
        c.fg = "#343b59"
        c.fg_dark = "#363c4d"
        c.fg_gutter = "#9da0ab"
        c.comment = "#707280"
        c.blue = "#2959aa"
        c.cyan = "#006c86"
        c.blue1 = "#33635c"
        c.purple = "#5a3e8e"
        c.magenta = "#5a3e8e"
        c.orange = "#8f5e15"
        c.yellow = "#8f5e15"
        c.green = "#485e30"
        c.teal = "#33635c"
        c.red = "#8c4351"

        c.bg_popup = c.bg_dark
        c.bg_statusline = c.bg_dark
        c.bg_sidebar = c.bg_dark
        c.bg_float = c.bg_dark
        c.fg_sidebar = c.fg_dark
        c.fg_float = c.fg
        c.todo = c.blue
        c.warning = c.yellow
        c.hint = c.teal
        c.rainbow = {
          c.blue,
          c.yellow,
          c.green,
          c.teal,
          c.magenta,
          c.purple,
          c.orange,
          c.red,
        }
      else
        c.comment = "#828bb8"
        c.fg_gutter = "#737aa2"
      end
    end,
    on_highlights = function(hl, c)
      if vim.o.background == "light" then
        hl["@markup.heading"] = { fg = c.fg, bold = true }
        hl.Title = { fg = c.fg, bold = true }

        -- High-contrast cursor word references
        local ref_bg = "#c8d0df"
        hl.LspReferenceText = { bg = ref_bg }
        hl.LspReferenceRead = { bg = ref_bg }
        hl.LspReferenceWrite = { bg = ref_bg, underline = true, sp = c.orange }

        -- Inlay hints with a faint background
        hl.LspInlayHint = { fg = c.comment, bg = c.bg_highlight }

        -- The stock day diff colors are all blue-grey, the same hue as Visual
        -- and LspReferenceText, so added, changed and selected text blur
        -- together. Give each diff kind its own hue; the DiffDelete fg keeps
        -- the filler hatching faint.
        hl.DiffAdd = { bg = "#d6e6cc" }
        hl.DiffDelete = { bg = "#f2dadd", fg = "#e3c3c8" }
        hl.DiffChange = { bg = "#efe9da" }
        hl.DiffText = { bg = "#e3cf9c" }
        hl.DiffTextAdd = { bg = "#b9d6a4" }
      else
        -- Same hue split as light, blended onto c.bg so it tracks the
        -- moon/storm/night background. The palette's green and yellow are
        -- pastels that blend to grey, so use saturated bases like stock
        -- DiffDelete's red1, which is already distinct.
        local util = require("tokyonight.util")
        hl.DiffAdd = { bg = util.blend_bg("#3d9a3d", 0.25) }
        hl.DiffChange = { bg = util.blend_bg("#c8902a", 0.10) }
        hl.DiffText = { bg = util.blend_bg("#c8902a", 0.30) }
        hl.DiffTextAdd = { bg = util.blend_bg("#3d9a3d", 0.45) }
      end

      -- Stock TreesitterContext is 80% fg_gutter, which the brighter
      -- fg_gutter overrides above turn into a mid-tone band that washes out
      -- the code text. Keep it subtle and mark its edge with an underline.
      hl.TreesitterContext = { bg = c.bg_highlight }
      hl.TreesitterContextBottom = { underline = true, sp = c.fg_gutter }

      -- Dampen indent guides (~50% blended toward c.bg) for both light and dark
      hl.SnacksIndent = { fg = blend_50(c.fg_gutter, c.bg), nocombine = true }
      local scope_fg = blend_50(c.blue1, c.bg)
      hl.SnacksIndentScope = { fg = scope_fg, nocombine = true }
      hl.SnacksIndentChunk = { fg = scope_fg, nocombine = true }
    end,
  },
}
