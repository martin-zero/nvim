--代码大纲
return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "上一个符号" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "下一个符号" })
      end,
    },

    keys = {
      {
        "<leader>o",
        "<cmd>AerialToggle!<CR>",
        desc = "切换代码大纲",
      },
    },
  },
}
