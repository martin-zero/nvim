require("nvchad.configs.lspconfig").defaults()

local lang = require "configs.lang"

local inlay_hint_group = vim.api.nvim_create_augroup("UserLspInlayHints", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = inlay_hint_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, args.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.lsp.config("csharp_ls", {
  cmd = {
    "/usr/bin/env",
    "DOTNET_ROOT=/opt/homebrew/opt/dotnet/libexec",
    "/Users/martin/.dotnet/tools/csharp-ls",
  },
})

vim.lsp.enable(lang.servers)

-- read :h vim.lsp.config for changing options of lsp servers
