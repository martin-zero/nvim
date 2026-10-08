return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {
      default_mappings = {
        ours = "<leader>go",
        theirs = "<leader>gt",
        both = "<leader>ga",
        none = "<leader>gn",
        next = "<leader>gj",
        prev = "<leader>gk",
      },
      default_commands = true,
      disable_diagnostics = false,
      list_opener = "copen",
    },
    keys = {
      { "<leader>gX", "<cmd>GitConflictListQf<CR>", desc = "列出冲突" },
      { "<leader>gr", "<cmd>GitConflictRefresh<CR>", desc = "刷新冲突" },
    },
  },
}
