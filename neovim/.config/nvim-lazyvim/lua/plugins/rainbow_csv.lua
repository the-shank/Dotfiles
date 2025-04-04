return {
  "mechatroner/rainbow_csv",
  ft = { "csv", "tsv", "psv", "rfc4180" }, -- Filetypes to activate the plugin for.
  config = function()
    vim.g.rainbow_csv_conceal = 0 -- disable concealing
    vim.keymap.set("n", "<leader>ra", ":RainbowAlign<CR>", { desc = "Rainbow Align CSV" })
    vim.keymap.set("n", "<leader>rs", ":RainbowShrink<CR>", { desc = "Rainbow UnAlign CSV" })
  end,
}
