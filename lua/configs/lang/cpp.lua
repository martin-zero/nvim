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
  },

  lsp_keymaps = {
    {
      server = "clangd",
      mode = "n",
      lhs = "<leader>cs",
      rhs = "<cmd>LspClangdSwitchSourceHeader<CR>",
    },
    "codelldb",
  },
}
