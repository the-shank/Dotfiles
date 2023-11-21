return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      context_commentstring = {
        enable = true,
        config = {
          c = "// %s",
          cpp = "// %s",
        },
      },
    },
  },
}
