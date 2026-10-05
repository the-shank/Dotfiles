return {
  {
    "dlyongemallo/diffview-plus.nvim",

    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    opts = {
      preferred_adapter = "jj",
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
