require("nvchad.configs.lspconfig").defaults()

local lang = require "configs.lang"

local function matches_server(keymap, client_name)
  if keymap.server then
    return keymap.server == client_name
  end

  if keymap.servers then
    return vim.tbl_contains(keymap.servers, client_name)
  end

  return true
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    for _, keymap in ipairs(lang.lsp_keymaps or {}) do
      if matches_server(keymap, client.name) then
        vim.keymap.set(keymap.mode or "n", keymap.lhs, keymap.rhs, {
          buffer = args.buf,
          desc = keymap.desc,
          expr = keymap.expr,
          remap = keymap.remap,
          silent = keymap.silent ~= false,
        })
      end
    end
  end,
})

-- 开启参数内联提示
vim.lsp.inlay_hint.enable(true)

vim.lsp.enable(lang.servers)

-- read :h vim.lsp.config for changing options of lsp servers
