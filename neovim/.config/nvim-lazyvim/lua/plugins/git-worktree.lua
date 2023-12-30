return {
  "telescope.nvim",
  dependencies = {
    "ThePrimeagen/git-worktree.nvim",
    lazy = false,
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
  },
  keys = {
    {
      "<leader>se",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "git worktrees",
    },
  },
}
