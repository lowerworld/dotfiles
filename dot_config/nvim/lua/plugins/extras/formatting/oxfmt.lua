vim.g.lazyvim_oxfmt_needs_config = true

local M = {}

---@param ctx ConformCtx
function M.has_config(ctx)
  return vim.fs.find(
    { ".oxfmtrc.json", ".oxfmtrc.jsonc" },
    { path = ctx.filename, upward = true, stop = vim.uv.os_homedir() }
  )[1] ~= nil
end

M.has_config = LazyVim.memoize(M.has_config)

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      vim
        .iter({
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "json",
          "vue",
        })
        :each(function(ft)
          opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
          table.insert(opts.formatters_by_ft[ft], "oxfmt")
        end)

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = {
        condition = function(_, ctx)
          return vim.g.lazyvim_oxfmt_needs_config ~= true or M.has_config(ctx)
        end,
      }
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "oxfmt" },
    },
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".oxfmtrc.json"] = { glyph = "", hl = "MiniIconsCyan" },
        [".oxfmtrc.jsonc"] = { glyph = "", hl = "MiniIconsCyan" },
      },
    },
  },
}
