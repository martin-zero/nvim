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

  lsp_keymaps = {
    {
      server = "clangd",
      mode = "n",
      lhs = "<leader>cs",
      rhs = "<cmd>LspClangdSwitchSourceHeader<CR>",
      desc = "切换头文件/源文件",
    },
  },

  dap = {
    c = "codelldb",
    cpp = "codelldb",
  },
}
