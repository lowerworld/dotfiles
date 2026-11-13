local lualine = require("lualine_require").lazy_require({
  utils = "lualine.utils.utils",
})

local apcall = require("plenary.async.util").apcall
local async = require("plenary.async")
local async_system = async.wrap(vim.system, 3)

local branch_cache = {}

local function refresh()
  local opts = { text = true, cwd = LazyVim.root.get() }

  async.run(
    function()
      local status = ""

      local ok, result = apcall(async_system, { "git", "rev-parse", "--is-inside-work-tree" }, opts)

      if ok and result.code == 0 and result.stdout:gsub("[\r\n]+$", "") == "true" then
        ok, result = apcall(async_system, { "git", "symbolic-ref", "--short", "HEAD" }, opts)

        if ok and result.code == 0 then
          status = result.stdout
        else
          ok, result = apcall(async_system, { "git", "rev-parse", "--short", "HEAD" }, opts)

          if ok and result.code == 0 then
            status = result.stdout
          end
        end
      end

      return lualine.utils.stl_escape(status:gsub("[\r\n]+$", ""))
    end,
    vim.schedule_wrap(function(status)
      branch_cache[opts.cwd] = status
    end)
  )
end

local M = require("lualine.component"):extend()

function M:init(options)
  M.super.init(self, options)

  vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = refresh })
end

function M:update_status()
  return branch_cache[LazyVim.root.get()] or ""
end

return M
