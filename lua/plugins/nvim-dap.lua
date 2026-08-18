return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "启动/继续调试",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "启动/继续调试",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "切换断点",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "切换断点",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "条件断点",
      },
      {
        "<leader>dL",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
        end,
        desc = "日志断点",
      },
      {
        "<leader>dC",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "清空断点",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "单步跳过",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "单步跳过",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "单步进入",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "单步进入",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "单步跳出",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "单步跳出",
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "查看光标下变量",
      },
      {
        "<leader>dp",
        function()
          require("dap.ui.widgets").preview()
        end,
        desc = "预览光标下变量",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "打开调试 REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "运行上次调试",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "结束调试",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "结束调试",
      },
      {
        "<C-S-F5>",
        function()
          require("dap").restart()
        end,
        desc = "重启调试",
      },
    },
    config = function()
      require "configs.dap"
    end,
  },
}
