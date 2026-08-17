require "nvchad.mappings"

local map = vim.keymap.set

local function move_if_exists(mode, from, to)
  local mapping = vim.fn.maparg(from, mode, false, true)

  if vim.tbl_isempty(mapping) then
    return
  end

  map(mode, to, mapping.callback or mapping.rhs, {
    remap = mapping.noremap == 0,
    silent = mapping.silent == 1,
    expr = mapping.expr == 1,
    nowait = mapping.nowait == 1,
    script = mapping.script == 1,
  })
  pcall(vim.keymap.del, mode, from)
end

map("n", ";", ":")
map("i", "jk", "<ESC>")

pcall(vim.keymap.del, "n", "<leader>pt")
pcall(vim.keymap.del, "n", "<leader>h")
pcall(vim.keymap.del, "n", "<leader>v")

move_if_exists("n", "<leader>ch", "<leader>hc")
move_if_exists("n", "<leader>wk", "<leader>hk")
move_if_exists("n", "<leader>wK", "<leader>hK")
move_if_exists("n", "<leader>fh", "<leader>hh")

move_if_exists("n", "<leader>cm", "<leader>gc")

move_if_exists("n", "<leader>n", "<leader>un")
move_if_exists("n", "<leader>rn", "<leader>ur")
move_if_exists("n", "<leader>th", "<leader>ut")

move_if_exists("n", "<leader>fm", "<leader>cf")
move_if_exists("x", "<leader>fm", "<leader>cf")

pcall(vim.keymap.del, "n", "<Tab>")
pcall(vim.keymap.del, "n", "<S-Tab>")

map("n", "<Tab>", function()
  pcall(function()
    require("sidekick").nes_jump_or_apply()
  end)
end)

map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<S-l>", ":bnext<CR>", { silent = true })
map("n", "<S-h>", ":bprevious<CR>", { silent = true })

map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

map("n", "<leader>q", ":qa<CR>")
