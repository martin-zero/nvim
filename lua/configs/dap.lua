local dap = require "dap"
local dapui = require "dapui"

dapui.setup()
require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticSignError" })

local mason = vim.fn.stdpath "data" .. "/mason/packages"
local codelldb = mason .. "/codelldb/extension/adapter/codelldb"
local netcoredbg = mason .. "/netcoredbg/netcoredbg"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb,
    args = { "--port", "${port}" },
  },
}

dap.adapters.coreclr = {
  type = "executable",
  command = netcoredbg,
  args = { "--interpreter=vscode" },
}

local native_debug_config = {
  {
    name = "启动当前程序",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("可执行文件路径: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "附加到进程",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.c = native_debug_config
dap.configurations.cpp = native_debug_config
dap.configurations.rust = native_debug_config

dap.configurations.cs = {
  {
    name = "启动 .NET 程序",
    type = "coreclr",
    request = "launch",
    program = function()
      return vim.fn.input("dll 路径: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
