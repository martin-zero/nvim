local dap = require "dap"
local lang = require "configs.lang"

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
