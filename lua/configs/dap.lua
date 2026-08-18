local dap = require "dap"
local lang = require "configs.lang"

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#db4b4b" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e0af68" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2a2e36" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine" })

local adapters = {
  codelldb = function()
    local mason = vim.fn.stdpath "data" .. "/mason/packages"

    return {
      type = "server",
      port = "${port}",
      executable = {
        command = mason .. "/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
      },
    }
  end,
}

local function native_debug_configs(adapter)
  return {
    {
      name = "Launch current program",
      type = adapter,
      request = "launch",
      program = function()
        return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Attach to process",
      type = adapter,
      request = "attach",
      pid = function()
        return require("dap.utils").pick_process()
      end,
      cwd = "${workspaceFolder}",
    },
  }
end

for _, adapter in pairs(lang.dap or {}) do
  if adapters[adapter] and not dap.adapters[adapter] then
    dap.adapters[adapter] = adapters[adapter]()
  end
end

for filetype, adapter in pairs(lang.dap or {}) do
  dap.configurations[filetype] = native_debug_configs(adapter)
end
