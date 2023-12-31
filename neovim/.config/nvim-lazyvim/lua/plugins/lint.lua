return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "MD034", "MD041", "--" },
        },
      },
    },
  },
}
