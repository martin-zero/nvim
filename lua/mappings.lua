require "nvchad.mappings"

-- add yours here
--
-- :T快速翻译
vim.api.nvim_create_user_command("T", function(opts)
  local text = ""

  if opts.range == 2 then
    -- Visual 模式选中的范围
    local s = vim.fn.getpos "'<"
    local e = vim.fn.getpos "'>"
    if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then
      s, e = e, s
    end
    local t = vim.api.nvim_buf_get_text(0, s[2] - 1, s[3] - 1, e[2] - 1, e[3], {})
    text = table.concat(t, "\n")
  else
    -- Normal 模式
    text = opts.args ~= "" and opts.args or vim.fn.expand "<cword>"
  end

  local output = vim.fn.system("trans " .. vim.fn.shellescape(text))
  print(output:gsub("\27%[[0-9;]*[mK]", ""))
end, { nargs = "*", range = true })

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
    ["<leader>n"] = "切换行号",
    ["<leader>rn"] = "切换相对行号",
    ["<leader>ch"] = "打开快捷键速查",
    ["<leader>cs"] = "切换头文件/源文件",
    ["<leader>fm"] = "格式化文件",
    ["<leader>ds"] = "诊断列表",
    ["<leader>b"] = "新建缓冲区",
    ["<tab>"] = "下一个缓冲区",
    ["<S-tab>"] = "上一个缓冲区",
    ["<leader>x"] = "关闭缓冲区",
    ["<leader>/"] = "切换注释",
    ["<C-n>"] = "切换文件树",
    ["<leader>e"] = "聚焦文件树",
    ["<leader>fw"] = "全文搜索",
    ["<leader>fb"] = "查找缓冲区",
    ["<leader>fh"] = "查找帮助",
    ["<leader>ma"] = "查找标记",
    ["<leader>fo"] = "查找最近文件",
    ["<leader>fz"] = "在当前缓冲区搜索",
    ["<leader>cm"] = "查找 Git 提交",
    ["<leader>gt"] = "查看 Git 状态",
    ["<leader>th"] = "切换主题",
    ["<leader>ff"] = "查找文件",
    ["<leader>fa"] = "查找所有文件",
    ["<A-v>"] = "切换垂直终端",
    ["<A-h>"] = "切换水平终端",
    ["<A-i>"] = "切换浮动终端",
    ["<leader>wK"] = "显示全部快捷键",
    ["<leader>wk"] = "查询快捷键",
  },
  v = {
    ["<leader>/"] = "切换注释",
  },
  x = {
    ["<leader>fm"] = "格式化选区",
  },
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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- 快速修复
map("n", "<leader>ca", vim.lsp.buf.code_action, {
  desc = "代码操作",
})

map("n", "<leader>cs", function()
  if vim.fn.exists ":LspClangdSwitchSourceHeader" == 2 then
    vim.cmd "LspClangdSwitchSourceHeader"
  else
    vim.notify("clangd 未提供头文件/源文件切换命令", vim.log.levels.WARN)
  end
end, {
  desc = "切换头文件/源文件",
})

map("n", "<S-l>", ":bnext<CR>", { silent = true })
map("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- alt + j/k移动行
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
