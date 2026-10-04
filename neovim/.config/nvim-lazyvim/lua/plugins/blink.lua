return {
  {
    "saghen/blink.cmp",
    keys = {
      {
        "<leader>uq",
        function()
          if vim.g.blink_cmp_autoshow == nil then
            vim.g.blink_cmp_autoshow = true
          end
          vim.g.blink_cmp_autoshow = not vim.g.blink_cmp_autoshow
          
          if vim.g.blink_cmp_autoshow then
            vim.notify("Autocomplete Auto-show Enabled", vim.log.levels.INFO, { title = "blink.cmp" })
          else
            vim.notify("Autocomplete Auto-show Disabled", vim.log.levels.INFO, { title = "blink.cmp" })
            -- Attempt to hide the completion menu if it's currently open
            require("blink.cmp").hide()
          end
        end,
        desc = "Toggle Autocomplete Auto-show",
      },
    },
    opts = function(_, opts)
      if vim.g.blink_cmp_autoshow == nil then
        vim.g.blink_cmp_autoshow = true
      end
      
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      
      -- Preserve any existing auto_show logic
      local orig_auto_show = opts.completion.menu.auto_show
      if orig_auto_show == nil then orig_auto_show = true end
      
      opts.completion.menu.auto_show = function(ctx, items)
        if not vim.g.blink_cmp_autoshow then
          return false
        end
        if type(orig_auto_show) == "function" then
          return orig_auto_show(ctx, items)
        end
        return orig_auto_show
      end
    end,
  },
}
