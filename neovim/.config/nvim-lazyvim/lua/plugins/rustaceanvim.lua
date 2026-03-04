return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Ensure you're on a recent version
    lazy = false,
    opts = {
      server = {
        default_settings = {
          -- This is the table that rust-analyzer actually reads
          ["rust-analyzer"] = {
            rustc = {
              source = "discover",
            },
            cargo = {
              sysroot = "discover",
              extraEnv = { RUSTC_BOOTSTRAP = "1" },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    },
  },
}
