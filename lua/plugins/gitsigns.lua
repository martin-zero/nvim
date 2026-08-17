-- git扩展功能
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text = true,
        virt_text_pos = "eol",
      },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame<CR>" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>" },
    },
  },
}
