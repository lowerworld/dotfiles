return {
  {
    "LudoPinelli/comment-box.nvim",
    event = "VeryLazy",
  },
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-lualine/lualine.nvim", "nvim-mini/mini.icons" },
    event = "VeryLazy",
    config = function()
      local incline = require("incline")

      incline.setup({
        render = function(props)
          local focused = props.win == vim.api.nvim_get_current_win()
          local parts = { focused and "▎" or " " }

          if focused then
            local lsp_clients = vim
              .iter(vim.lsp.get_clients({ bufnr = props.buf }))
              :map(function(client)
                return client.name
              end)
              :totable()

            if not vim.tbl_isempty(lsp_clients) then
              vim.list_extend(parts, {
                { "", group = "MiniIconsYellow" },
                " ",
                table.concat(lsp_clients, " "),
                " ",
                { "󰇝", group = "lualine_c_inactive" },
                " ",
              })
            end
          end

          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local modified = vim.api.nvim_get_option_value("modified", { buf = props.buf })
          local icon, hl = require("mini.icons").get("file", filename)

          vim.list_extend(parts, {
            { icon, group = hl },
            " ",
            {
              filename ~= "" and filename or "[Scratch]",
              group = modified and "MatchParen" or nil,
            },
          })

          return parts
        end,
        window = {
          margin = {
            horizontal = 0,
            vertical = 0,
          },
          padding = {
            left = 0,
            right = 1,
          },
          winhighlight = {
            Normal = "lualine_c_normal",
          },
          zindex = 30,
        },
      })

      vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
        callback = function()
          incline.refresh()
        end,
      })
    end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "BufRead package.json",
    opts = {},
  },
  {
    "gisketch/triforce.nvim",
    dependencies = { "nvzone/volt" },
    event = "VeryLazy",
    opts = function()
      return {
        enabled = not vim.list_contains({ "gitcommit", "gitrebase" }, vim.bo.filetype),
      }
    end,
  },
  {
    "nvzone/typr",
    dependencies = { "nvzone/volt" },
    cmd = { "Typr", "TyprStats" },
    opts = {},
  },
}
