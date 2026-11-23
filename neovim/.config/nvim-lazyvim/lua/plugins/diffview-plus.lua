return {
  {
    "dlyongemallo/diffview-plus.nvim",

    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    opts = function()
      local actions = require("diffview.actions")
      -- diffview-plus registers fold compatibility mappings with
      -- `desc = "diffview_ignore"`, which hides their meaning in `<leader>sk`
      -- and overrides which-key's `z` popup labels in diff panes.
      local fold_descs = {
        za = "Toggle fold under cursor",
        zA = "Toggle all folds under cursor",
        zo = "Open fold under cursor",
        zO = "Open all folds under cursor",
        zc = "Close fold under cursor",
        zC = "Close all folds under cursor",
        zr = "Fold less",
        zR = "Open all folds",
        zm = "Fold more",
        zM = "Close all folds",
        zi = "Toggle folding",
        zv = "Show cursor line",
        zx = "Update folds",
        zX = "Reapply folds",
        ze = "Scroll horizontally (cursor right)",
        zE = "Delete all folds in file",
        zn = "Disable folding",
        zN = "Enable folding",
      }

      local fold_maps = {}
      for _, m in ipairs(actions.compat.fold_cmds) do
        local lhs = m[2]
        local desc = assert(fold_descs[lhs], "missing fold description for " .. lhs)
        table.insert(fold_maps, { m[1], lhs, m[3], { desc = desc } })
      end

      local view_maps = vim.list_extend(fold_maps, {
        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
      })

      local panel_maps = {
        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
      }

      return {
        preferred_adapter = "jj",
        persist_selections = { enabled = true },
        keymaps = {
          view = view_maps,
          file_panel = panel_maps,
          file_history_panel = panel_maps,
        },
      }
    end,

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
        "<cmd>DiffviewToggle<cr>",
        desc = "Toggle Diffview window",
      },
    },
  },
}
