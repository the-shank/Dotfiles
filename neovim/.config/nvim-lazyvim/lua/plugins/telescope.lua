return {
  "nvim-telescope/telescope.nvim",
  -- "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  keys = {
    {
      "<leader>fg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "telescope live grep args",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("live_grep_args")
  end,
  opts = function()
    local lga_actions = require("telescope-live-grep-args.actions")
    local picker_fraction = 0.95
    return {
      -- hack: the layout config should be in a separate file but I am
      -- unable to figure out how to do it :(
      defaults = {
        layout_config = {
          width = function(_, max_columns, _)
            return math.floor(picker_fraction * max_columns)
          end,
          height = function(_, _, max_lines)
            return math.floor(picker_fraction * max_lines)
          end,
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
    }
  end,
}
