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
          desc = "文件树: 折叠全部",
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

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "调试: 启动/继续",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "调试: 单步跳过",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "调试: 单步进入",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "调试: 单步跳出",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "调试: 切换断点",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "断点条件: ")
        end,
        desc = "调试: 条件断点",
      },
      {
        "<leader>dl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input "日志内容: ")
        end,
        desc = "调试: 日志断点",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "调试: 打开 REPL",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "调试: 切换界面",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "调试: 结束",
      },
    },
    config = function()
      require "configs.dap"
    end,
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
