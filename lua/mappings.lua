require "nvchad.mappings"

local map = vim.keymap.set

local function remap_if_exists(mode, lhs, desc)
  local modes = type(mode) == "table" and mode or { mode }

  for _, current_mode in ipairs(modes) do
    local mapping = vim.fn.maparg(lhs, current_mode, false, true)

    if not vim.tbl_isempty(mapping) then
      local rhs = mapping.callback or mapping.rhs
      local opts = {
        desc = desc,
        remap = mapping.noremap == 0,
        silent = mapping.silent == 1,
        expr = mapping.expr == 1,
        nowait = mapping.nowait == 1,
        script = mapping.script == 1,
      }

      map(current_mode, lhs, rhs, opts)
    end
  end
end

local function move_if_exists(mode, from, to, desc)
  local mapping = vim.fn.maparg(from, mode, false, true)

  if vim.tbl_isempty(mapping) then
    return
  end

  map(mode, to, mapping.callback or mapping.rhs, {
    desc = desc or mapping.desc,
    remap = mapping.noremap == 0,
    silent = mapping.silent == 1,
    expr = mapping.expr == 1,
    nowait = mapping.nowait == 1,
    script = mapping.script == 1,
  })
  pcall(vim.keymap.del, mode, from)
end

map("n", ";", ":", { desc = "进入命令模式" })
map("i", "jk", "<ESC>")

local chinese_desc = {
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
  x = {},
  t = {
    ["<C-x>"] = "退出终端模式",
    ["<A-v>"] = "切换垂直终端",
    ["<A-h>"] = "切换水平终端",
    ["<A-i>"] = "切换浮动终端",
  },
}

for mode, mappings in pairs(chinese_desc) do
  for lhs, desc in pairs(mappings) do
    remap_if_exists(mode, lhs, desc)
  end
end

pcall(vim.keymap.del, "n", "<leader>pt")
pcall(vim.keymap.del, "n", "<leader>h")
pcall(vim.keymap.del, "n", "<leader>v")

move_if_exists("n", "<leader>ch", "<leader>hc", "打开快捷键速查")
move_if_exists("n", "<leader>wk", "<leader>hk", "查询快捷键")
move_if_exists("n", "<leader>wK", "<leader>hK", "显示全部快捷键")
move_if_exists("n", "<leader>fh", "<leader>hh", "查找帮助")

move_if_exists("n", "<leader>cm", "<leader>gc", "查找 Git 提交")

move_if_exists("n", "<leader>n", "<leader>un", "切换行号")
move_if_exists("n", "<leader>rn", "<leader>ur", "切换相对行号")
move_if_exists("n", "<leader>th", "<leader>ut", "切换主题")

move_if_exists("n", "<leader>fm", "<leader>cf", "格式化文件")
move_if_exists("x", "<leader>fm", "<leader>cf", "格式化选区")

pcall(vim.keymap.del, "n", "<Tab>")
pcall(vim.keymap.del, "n", "<S-Tab>")

map("n", "<Tab>", function()
  pcall(function()
    require("sidekick").nes_jump_or_apply()
  end)
end, { desc = "跳转/应用下一个编辑建议" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- 快速修复
map("n", "<leader>ca", vim.lsp.buf.code_action, {
  desc = "快速修复",
})

map("n", "<S-l>", ":bnext<CR>", { silent = true })
map("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- alt + j/k移动行
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- 退出nvim
map("n", "<leader>q", ":qa<CR>", { desc = "退出" })
