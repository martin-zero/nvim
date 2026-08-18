-- 自定义翻译插件
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

        vim.system({ "trans", "--", text }, { text = true }, function(result)
          vim.schedule(function()
            if result.code ~= 0 then
              vim.notify(result.stderr ~= "" and result.stderr or "Translation failed", vim.log.levels.ERROR)
              return
            end

            print(result.stdout:gsub("\27%[[0-9;]*[mK]", ""))
          end)
        end)
      end, { nargs = "*", range = true })
    end,
  },
}
