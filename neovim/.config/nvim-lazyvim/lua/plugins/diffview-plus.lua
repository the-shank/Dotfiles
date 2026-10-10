return {
  {
    "dlyongemallo/diffview-plus.nvim",

    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    opts = {
      preferred_adapter = "jj",
    },

    -- `keys` alone makes lazy.nvim defer loading until <leader>dv is pressed,
    -- so these commands would not exist for `nvim +DiffviewOpen` (used by the
    -- `jjd` fish function) or for jj's merge and diff editor integration.
    cmd = {
      "DiffviewOpen",
      "DiffviewToggle",
      "DiffviewFileHistory",
      "DiffviewDiffFiles",
      "DiffviewMergeFiles",
      "DiffviewDiffDirs",
    },

    keys = {
      {
        "<leader>dv",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Toggle Diffview window",
      },
    },
  },
}
