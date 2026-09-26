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
        c.bg = "#e6e7ed"
        c.bg_dark = "#d6d8df"
        c.bg_highlight = "#dcdee3"
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
      end
    end,
    on_highlights = function(hl, c)
      if vim.o.background == "light" then
        hl["@markup.heading"] = { fg = c.fg, bold = true }
        hl.Title = { fg = c.fg, bold = true }
      end
    end,
  },
}
