return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    event = "BufReadPost",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local dropbar_api = require "dropbar.api"
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "选择 winbar 符号" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "跳到当前上下文开头" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "选择下一个上下文" })
    end,
  },
}
