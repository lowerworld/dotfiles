local M = require("lualine.component"):extend()

function M:init(options)
  M.super.init(self, options)

  vim.uv.new_timer():start(0, 1000, vim.schedule_wrap(M.refresh))
  vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = M.refresh })
end

function M:update_status()
  return M.status
end

function M:refresh()
  M.status = vim
    .iter(LazyVim.format.resolve())
    :map(function(formatter)
      return formatter.active and formatter.resolved or nil
    end)
    :flatten()
    :join(" ")
end

return M
