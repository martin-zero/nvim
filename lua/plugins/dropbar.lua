-- 面包屑导航栏
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
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick)
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start)
      vim.keymap.set("n", "];", dropbar_api.select_next_context)
    end,
  },
}
