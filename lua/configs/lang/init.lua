local enabled_modules = {
  -- "web",
  "cpp",
  "java",
  "lua",
  "rust",
  "copilot",
}

local M = {
  enabled = enabled_modules,
  servers = {},
  formatters_by_ft = {},
  mason = {},
  plugins = {},
  lsp_keymaps = {},
  dap = {},
}

local function append(target, items)
  for _, item in ipairs(items or {}) do
    table.insert(target, item)
  end
end

for _, name in ipairs(enabled_modules) do
  local ok, lang = pcall(require, "configs.lang." .. name)

  if not ok then
    vim.notify("Failed to load language config: " .. name, vim.log.levels.ERROR)
    return
  end

  for ft, formatters in pairs(lang.formatters_by_ft or {}) do
    M.formatters_by_ft[ft] = formatters
  end

  append(M.servers, lang.servers)
  append(M.mason, lang.mason)
  append(M.plugins, lang.plugins)
  append(M.lsp_keymaps, lang.lsp_keymaps)

  for filetype, adapter in pairs(lang.dap or {}) do
    M.dap[filetype] = adapter
  end
end

return M
