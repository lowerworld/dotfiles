---@type LazyPluginSpec[]
return {
  { "LudoPinelli/comment-box.nvim" },
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-lualine/lualine.nvim" },
    event = "VeryLazy",
    opts = {
      render = function(props)
        local lsp_clients = vim
          .iter(vim.lsp.get_clients({ bufnr = props.buf }))
          :map(function(client)
            return client.name
          end)
          :totable()

        return not vim.tbl_isempty(lsp_clients) and vim.iter({ "", lsp_clients }):flatten():join(" ") or ""
      end,
      window = {
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        winhighlight = {
          Normal = "lualine_b_normal",
        },
        zindex = 30,
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = true,
  },
}
