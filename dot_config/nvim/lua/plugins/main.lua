return {
  { "LudoPinelli/comment-box.nvim" },
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-lualine/lualine.nvim", "nvim-mini/mini.icons" },
    event = "VeryLazy",
    opts = function()
      local hl = vim.api.nvim_get_hl(0, { name = "MiniIconsYellow" })
      local icon = { "", guifg = hl.fg ~= nil and ("#%X"):format(hl.fg) or nil }

      return {
        render = function(props)
          local lsp_clients = vim
            .iter(vim.lsp.get_clients({ bufnr = props.buf }))
            :map(function(client)
              return client.name
            end)
            :totable()

          return not vim.tbl_isempty(lsp_clients) and { icon, " ", table.concat(lsp_clients, "⋮") } or ""
        end,
        window = {
          margin = {
            horizontal = 0,
            vertical = 0,
          },
          winhighlight = {
            Normal = "lualine_c_normal",
          },
          zindex = 30,
        },
      }
    end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
