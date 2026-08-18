require "nvchad.mappings"

require("configs.whichkey").setup()

local map = vim.keymap.set

local function move_key(mode, from, to, desc)
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
map("i", "jk", "<ESC>", { desc = "退出插入模式" })

pcall(vim.keymap.del, "n", "<leader>pt")
pcall(vim.keymap.del, "n", "<leader>h")
pcall(vim.keymap.del, "n", "<leader>v")

move_key("n", "<leader>ch", "<leader>hc", "打开快捷键速查")
move_key("n", "<leader>wk", "<leader>hk", "查询快捷键")
move_key("n", "<leader>wK", "<leader>hK", "显示全部快捷键")
move_key("n", "<leader>fh", "<leader>hh", "查找帮助")

move_key("n", "<leader>cm", "<leader>gc", "查找 Git 提交")

move_key("n", "<leader>n", "<leader>un", "切换行号")
move_key("n", "<leader>rn", "<leader>ur", "切换相对行号")
move_key("n", "<leader>th", "<leader>ut", "切换主题")

move_key("n", "<leader>fm", "<leader>cf", "格式化文件")
move_key("x", "<leader>fm", "<leader>cf", "格式化选区")

pcall(vim.keymap.del, "n", "<Tab>")
pcall(vim.keymap.del, "n", "<S-Tab>")

map("n", "<Tab>", function()
  pcall(function()
    require("sidekick").nes_jump_or_apply()
  end)
end, { desc = "跳转/应用下一个编辑建议" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "代码操作" })

map("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "下一个缓冲区" })
map("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "上一个缓冲区" })

map("n", "<A-j>", ":m .+1<CR>==", { desc = "下移当前行" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "上移当前行" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "下移选区" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "上移选区" })

map("n", "<leader>q", ":qa<CR>", { desc = "退出 Neovim" })
