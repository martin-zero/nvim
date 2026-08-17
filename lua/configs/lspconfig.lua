require("nvchad.configs.lspconfig").defaults()

local lang = require "configs.lang"

local inlay_hint_group = vim.api.nvim_create_augroup("UserLspInlayHints", { clear = true })

-- 开启参数内联提示
vim.lsp.inlay_hint.enable(true)

vim.lsp.enable(lang.servers)

-- read :h vim.lsp.config for changing options of lsp servers
