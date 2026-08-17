local lang = require "configs.lang"

local plugins = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

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

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = {
      ensure_installed = lang.mason,
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}

vim.list_extend(plugins, lang.plugins)

return plugins
