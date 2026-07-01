require("nvchad.configs.lspconfig").defaults()

local lang = require "configs.lang"

vim.lsp.enable(lang.servers)

-- read :h vim.lsp.config for changing options of lsp servers
