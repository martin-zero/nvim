local wk = require "which-key"

wk.add {
  { "<leader>c", group = "代码" },
  { "<leader>d", group = "诊断/调试" },
  { "<leader>f", group = "查找" },
  { "<leader>g", group = "Git" },
  { "<leader>m", group = "标记" },
  { "<leader>r", group = "重构/工作区" },
  { "<leader>t", group = "主题/工具" },
  { "<leader>w", group = "工作区/快捷键" },
}

local function map_exists(mode, lhs)
  return not vim.tbl_isempty(vim.fn.maparg(lhs, mode, false, true))
end

local function add_if_exists(items)
  local available = {}

  for _, item in ipairs(items) do
    local mode = item.mode or "n"

    if map_exists(mode, item[1]) then
      table.insert(available, item)
    end
  end

  if #available > 0 then
    wk.add(available)
  end
end

add_if_exists {
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local function remap_lsp(lhs, desc)
        local mapping

        for _, item in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
          if item.lhs == lhs then
            mapping = item
            break
          end
        end

        if not mapping then
          return
        end

        vim.keymap.set("n", lhs, mapping.callback or mapping.rhs, {
          buffer = args.buf,
          desc = desc,
          remap = mapping.noremap == 0,
          silent = mapping.silent == 1,
          expr = mapping.expr == 1,
          nowait = mapping.nowait == 1,
        })
      end

      remap_lsp("gD", "跳转到声明")
      remap_lsp("gd", "跳转到定义")
      remap_lsp("<leader>D", "跳转到类型定义")
      remap_lsp("<leader>wa", "添加工作区文件夹")
      remap_lsp("<leader>wr", "移除工作区文件夹")
      remap_lsp("<leader>wl", "列出工作区文件夹")

      vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, {
        buffer = args.buf,
        desc = "重命名",
      })
    end)
  end,
})
