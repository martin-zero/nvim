return {
  servers = {
    "clangd",
  },

  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
  },

  mason = {
    "clangd",
    "clang-format",
    "codelldb",
  },

  dap = {
    c = "codelldb",
    cpp = "codelldb",
  },
}
