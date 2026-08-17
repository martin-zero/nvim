return {
  {
    "user/translate",
    dir = vim.fn.stdpath "config",
    name = "translate",
    cmd = "T",
    config = function()
      vim.api.nvim_create_user_command("T", function(opts)
        local text

        if opts.range == 2 then
          local start_pos = vim.fn.getpos "'<"
          local end_pos = vim.fn.getpos "'>"

          if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
            start_pos, end_pos = end_pos, start_pos
          end

          local lines = vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
          text = table.concat(lines, "\n")
        else
          text = opts.args ~= "" and opts.args or vim.fn.expand "<cword>"
        end

        local output = vim.fn.system("trans " .. vim.fn.shellescape(text))
        print(output:gsub("\27%[[0-9;]*[mK]", ""))
      end, { nargs = "*", range = true })
    end,
  },
}
