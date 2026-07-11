require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- 相对行号
-- vim.o.relativenumber = true

-- 关闭注释自动续行
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove "r"
    vim.opt_local.formatoptions:remove "o"
    vim.opt_local.formatoptions:remove "c"
  end,
})

vim.opt.clipboard = "unnamedplus"
