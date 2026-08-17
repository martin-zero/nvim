return {
  formatters_by_ft = {
    rust = { "rustfmt" },
  },

  plugins = {
    {
      "mrcjkb/rustaceanvim",
      version = "^9",
      lazy = false,
    },
  },

  mason = {
    "codelldb",
  },

  dap = {
    rust = "codelldb",
  },
}
