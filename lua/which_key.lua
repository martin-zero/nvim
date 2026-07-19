local wk = require "which-key"

local leader_groups = {
  { "<leader>a", group = "AI 助手" },
  { "<leader>c", group = "代码操作" },
  { "<leader>d", group = "调试/诊断" },
  { "<leader>f", group = "文件/搜索" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "帮助" },
  { "<leader>m", group = "标记" },
  { "<leader>o", group = "代码大纲" },
  { "<leader>r", group = "重构" },
  { "<leader>u", group = "界面" },
  { "<leader>w", group = "工作区" },
}

local lsp_keymaps = {
  { "gD", desc = "跳转到声明" },
  { "gd", desc = "跳转到定义" },
  { "grd", desc = "查找定义" },
  { "grr", desc = "查找引用" },
  { "gri", desc = "查找实现" },
  { "grt", desc = "查找类型定义" },
  { "<leader>D", desc = "跳转到类型定义" },
  { "<leader>ra", desc = "重命名" },
  { "<leader>wa", desc = "添加工作区文件夹" },
  { "<leader>wr", desc = "移除工作区文件夹" },
  { "<leader>wl", desc = "列出工作区文件夹" },
}

local function normal_map_exists(lhs)
  return not vim.tbl_isempty(vim.fn.maparg(lhs, "n", false, true))
end

local function add_existing_normal_maps(items)
  local existing = {}

  for _, item in ipairs(items) do
    if normal_map_exists(item[1]) then
      table.insert(existing, item)
    end
  end

  if #existing > 0 then
    wk.add(existing)
  end
end

local function find_buffer_normal_map(bufnr, lhs)
  for _, item in ipairs(vim.api.nvim_buf_get_keymap(bufnr, "n")) do
    if item.lhs == lhs then
      return item
    end
  end
end

local function set_buffer_map_desc(bufnr, lhs, desc)
  local mapping = find_buffer_normal_map(bufnr, lhs)

  if not mapping then
    return
  end

  vim.keymap.set("n", lhs, mapping.callback or mapping.rhs, {
    buffer = bufnr,
    desc = desc,
    remap = mapping.noremap == 0,
    silent = mapping.silent == 1,
    expr = mapping.expr == 1,
    nowait = mapping.nowait == 1,
  })
end

wk.add(leader_groups)
add_existing_normal_maps(lsp_keymaps)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      for _, item in ipairs(lsp_keymaps) do
        set_buffer_map_desc(args.buf, item[1], item.desc)
      end

      vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, {
        buffer = args.buf,
        desc = "重命名",
      })
    end)
  end,
})
