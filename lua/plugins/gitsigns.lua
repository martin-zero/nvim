return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      -- current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d %H:%M> - <summary>",
      current_line_blame_opts = {
        delay = 500,
        virt_text = true,
        virt_text_pos = "eol",
      },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame<CR>", desc = "文件提交信息" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "比较当前文件" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "预览修改块" },
    },
  },
}
