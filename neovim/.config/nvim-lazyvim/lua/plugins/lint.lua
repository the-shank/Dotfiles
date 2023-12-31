return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD007", "MD013", "MD034", "MD041", "--" },
        },
      },
    },
  },
}
