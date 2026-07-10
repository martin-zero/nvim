local enabled = {
  -- "web",
  "cpp",
  "csharp",
  "java",
  "lua",
  "rust",
}

local M = {
  enabled = enabled,
  servers = {},
  formatters_by_ft = {},
  mason = {},
  plugins = {},
}

local function extend_list(dst, src)
  if not src then
    return
  end

  for _, item in ipairs(src) do
    table.insert(dst, item)
  end
end

for _, name in ipairs(enabled) do
  local ok, lang = pcall(require, "configs.lang." .. name)
  if not ok then
    vim.notify("Failed to load language config: " .. name, vim.log.levels.ERROR)
  else
    vim.list_extend(M.servers, lang.servers or {})

    for ft, formatters in pairs(lang.formatters_by_ft or {}) do
      M.formatters_by_ft[ft] = formatters
    end

    extend_list(M.mason, lang.mason)
    extend_list(M.plugins, lang.plugins)
  end
end

return M
