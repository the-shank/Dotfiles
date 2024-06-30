return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      height = 0.95,
      width = 0.95,
    },
  },
  keys = {
    { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  },
}
