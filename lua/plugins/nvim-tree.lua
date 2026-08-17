return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      local api = require "nvim-tree.api"

      opts.on_attach = function(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "Z", api.tree.collapse_all, {
          buffer = bufnr,
          nowait = true,
          silent = true,
        })
      end
    end,
  },
}
