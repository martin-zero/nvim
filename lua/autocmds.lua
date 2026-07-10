require "nvchad.autocmds"

local english_input = "com.apple.keylayout.ABC"

local function input_source_cmd()
  if vim.fn.executable "im-select" == 1 then
    return "im-select"
  end

  if vim.fn.executable "/opt/homebrew/bin/im-select" == 1 then
    return "/opt/homebrew/bin/im-select"
  end

  if vim.fn.executable "macism" == 1 then
    return "macism"
  end

  if vim.fn.executable "/opt/homebrew/bin/macism" == 1 then
    return "/opt/homebrew/bin/macism"
  end
end

local function switch_to_english()
  local cmd = input_source_cmd()

  if cmd then
    vim.fn.jobstart({ cmd, english_input }, { detach = true })
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave", "CmdlineLeave" }, {
  callback = switch_to_english,
})
