return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  init = function()
    vim.g.vimtex_view_method = "zathura"
  end,
}
