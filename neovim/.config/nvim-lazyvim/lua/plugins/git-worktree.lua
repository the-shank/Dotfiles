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
      "<leader>gws",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "git worktree search",
    },
    {
      "<leader>gwc",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "git worktree create",
    },
  },
}
