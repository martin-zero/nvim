local M = {}

local descs = {
  i = {
    ["<C-b>"] = "移动到行首",
    ["<C-e>"] = "移动到行尾",
    ["<C-h>"] = "左移光标",
    ["<C-l>"] = "右移光标",
    ["<C-j>"] = "下移光标",
    ["<C-k>"] = "上移光标",
  },
  n = {
    ["<C-h>"] = "切到左侧窗口",
    ["<C-l>"] = "切到右侧窗口",
    ["<C-j>"] = "切到下方窗口",
    ["<C-k>"] = "切到上方窗口",
    ["<Esc>"] = "清除搜索高亮",
    ["<C-s>"] = "保存文件",
    ["<C-c>"] = "复制整个文件",
    ["<leader>ds"] = "诊断列表",
    ["<leader>b"] = "新建缓冲区",
    ["<leader>x"] = "关闭缓冲区",
    ["<leader>/"] = "切换注释",
    ["<C-n>"] = "切换文件树",
    ["<leader>e"] = "聚焦文件树",
    ["<leader>fw"] = "全文搜索",
    ["<leader>fb"] = "查找缓冲区",
    ["<leader>ma"] = "查找标记",
    ["<leader>fo"] = "查找最近文件",
    ["<leader>fz"] = "在当前缓冲区搜索",
    ["<leader>gt"] = "查看 Git 状态",
    ["<leader>ff"] = "查找文件",
    ["<leader>fa"] = "查找所有文件",
    ["<A-v>"] = "切换垂直终端",
    ["<A-h>"] = "切换水平终端",
    ["<A-i>"] = "切换浮动终端",
  },
  v = {
    ["<leader>/"] = "切换注释",
  },
  t = {
    ["<C-x>"] = "退出终端模式",
    ["<A-v>"] = "切换垂直终端",
    ["<A-h>"] = "切换水平终端",
    ["<A-i>"] = "切换浮动终端",
  },
}

local groups = {
  { "<C-w>", group = "窗口" },
  { "<C-w>h", desc = "切到左侧窗口" },
  { "<C-w>j", desc = "切到下方窗口" },
  { "<C-w>k", desc = "切到上方窗口" },
  { "<C-w>l", desc = "切到右侧窗口" },
  { "<C-w>H", desc = "移动窗口到最左侧" },
  { "<C-w>J", desc = "移动窗口到最下方" },
  { "<C-w>K", desc = "移动窗口到最上方" },
  { "<C-w>L", desc = "移动窗口到最右侧" },
  { "<C-w>s", desc = "水平分割窗口" },
  { "<C-w>v", desc = "垂直分割窗口" },
  { "<C-w>c", desc = "关闭窗口" },
  { "<C-w>q", desc = "退出窗口" },
  { "<C-w>o", desc = "只保留当前窗口" },
  { "<C-w>T", desc = "移到新标签页" },
  { "<C-w>x", desc = "与下一个窗口交换" },
  { "<C-w>d", desc = "显示光标下诊断" },
  { "<C-w><C-d>", desc = "显示光标下诊断" },
  { "<C-w>=", desc = "等分窗口大小" },
  { "<C-w>_", desc = "最大化窗口高度" },
  { "<C-w>|", desc = "最大化窗口宽度" },
  { "<C-w>+", desc = "增加窗口高度" },
  { "<C-w>-", desc = "减少窗口高度" },
  { "<C-w>>", desc = "增加窗口宽度" },
  { "<C-w><", desc = "减少窗口宽度" },
  { "<C-w>w", desc = "切到下一个窗口" },
  { "<C-w>W", desc = "切到上一个窗口" },
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

local function apply_desc(mode, lhs, desc)
  local mapping = vim.fn.maparg(lhs, mode, false, true)

  if vim.tbl_isempty(mapping) then
    return
  end

  vim.keymap.set(mode, lhs, mapping.callback or mapping.rhs, {
    desc = desc,
    remap = mapping.noremap == 0,
    silent = mapping.silent == 1,
    expr = mapping.expr == 1,
    nowait = mapping.nowait == 1,
    script = mapping.script == 1,
  })
end

function M.setup()
  for mode, maps in pairs(descs) do
    for lhs, desc in pairs(maps) do
      apply_desc(mode, lhs, desc)
    end
  end

  local ok, wk = pcall(require, "which-key")

  if ok then
    wk.add(groups)
  end
end

return M
