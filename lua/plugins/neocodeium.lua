return {
  -- AI代码补全
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      -- 接受全部补全
      vim.keymap.set("i", "<A-f>", function()
        require("neocodeium").accept()
      end)
      -- 接受一个单词
      vim.keymap.set("i", "<A-w>", function()
        require("neocodeium").accept_word()
      end)
      -- 接受一行
      vim.keymap.set("i", "<A-a>", function()
        require("neocodeium").accept_line()
      end)
      -- 上一个补全
      vim.keymap.set("i", "<A-e>", function()
        require("neocodeium").cycle_or_complete()
      end)
      -- 下一个补全
      vim.keymap.set("i", "<A-r>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      -- 清除
      vim.keymap.set("i", "<A-c>", function()
        require("neocodeium").clear()
      end)
    end,
  },
}
