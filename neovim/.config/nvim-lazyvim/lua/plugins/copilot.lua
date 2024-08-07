return {
  -- add to which-key menu
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p", group = "copilot" },
      },
    },
  },

  -- setup the copilot plugin
  {

    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<esc>",
      },
    },
  },
}
