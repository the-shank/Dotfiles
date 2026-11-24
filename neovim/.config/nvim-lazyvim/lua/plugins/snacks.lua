return {
  "folke/snacks.nvim",
  opts = {
    statuscolumn = {
      -- In diff windows gitsigns marks only the working-copy pane, repeating
      -- what the diff already shows. `signcolumn = "no"` cannot hide them:
      -- snacks renders its `git` component regardless of that option.
      -- snacks caches signs per buffer for 50ms, so a non-diff window showing
      -- the same buffer in the same tab can miss git signs until a redraw;
      -- diffview opens in its own tab, so this does not come up there.
      right = function(win)
        return vim.wo[win].diff and { "fold" } or { "fold", "git" }
      end,
    },
  },
}
