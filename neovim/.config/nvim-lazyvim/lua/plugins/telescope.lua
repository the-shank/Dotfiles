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
      "<leader><space>",
      function()
        -- require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
        require("telescope.builtin").find_files({
          find_command = {
            "fd",
            "--ignore-case",
            "--hidden",
            "--no-ignore-vcs",
            "--type=f",
            "--exclude=.git/",
            "--exclude=target/",
            "--exclude=.venv/",
          },
        })
      end,
      desc = "telescope find files",
    },
    {
      "<leader>/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "telescop grep",
    },
    {
      "<leader>fg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "telescope live grep args",
    },
    {
      "<leader>sS",
      function()
        -- require("telescope").lsp_workspace_symbols()
        require("telescope.builtin").lsp_workspace_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (workspace)",
    },
    {
      "<leader>sB",
      function()
        -- require("telescope").lsp_workspace_symbols()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (workspace)",
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
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          width = function(_, max_columns, _)
            return math.floor(picker_fraction * max_columns)
          end,
          height = function(_, _, max_lines)
            return math.floor(picker_fraction * max_lines)
          end,
          prompt_position = "bottom",
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
