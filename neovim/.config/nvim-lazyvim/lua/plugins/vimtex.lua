return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_log_ignore = {
      "Underfull",
      "Overfull",
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull",
      "Overfull",
    }
    -- source: https://github.com/abzcoding/lvim/blob/main/lua/user/tex.lua
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-pdf",
      pdflatex = "-pdf",
      dvipdfex = "-pdfdvi",
      lualatex = "-lualatex",
      xelatex = "-xelatex",
    }
    vim.g.vimtex_compiler_latexrun_engines = {
      _ = "pdflatex",
      pdflatex = "pdflatex",
      lualatex = "lualatex",
      xelatex = "xelatex",
    }
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}
