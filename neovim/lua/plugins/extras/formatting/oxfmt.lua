return {
  desc = "Oxfmt is a high-performance formatter for the JavaScript ecosystem.",
  -- {
  --   "stevearc/conform.nvim",
  --   opts = function(_, opts)
  --     local supported_ft = {
  --       "javascript",
  --       "javascriptreact",
  --       "typescript",
  --       "typescriptreact",
  --       "json",
  --       "jsonc",
  --       "json5",
  --       "yaml",
  --       "toml",
  --       "html",
  --       "angular",
  --       "vue",
  --       "css",
  --       "scss",
  --       "less",
  --       "markdown",
  --       "markdown.mdx",
  --       "graphql",
  --       "ember",
  --       "handlebars",
  --     }
  --
  --     opts.formatters_by_ft = opts.formatters_by_ft or {}
  --
  --     vim.iter(supported_ft):each(function(ft)
  --       opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
  --       table.insert(opts.formatters_by_ft[ft], "oxfmt")
  --     end)
  --
  --     return vim.tbl_deep_extend("force", opts, {
  --       formatters = {
  --         oxfmt = {
  --           cwd = require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
  --           require_cwd = vim.g.lazyvim_oxfmt_needs_config ~= false,
  --         },
  --       },
  --     })
  --   end,
  -- },
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
        [".oxfmtrc.json"] = { glyph = "", hl = "MiniIconsAzure" },
        [".oxfmtrc.jsonc"] = { glyph = "", hl = "MiniIconsAzure" },
        ["oxfmt.config.ts"] = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxfmt = {
          -- enabled = false,
          root_markers = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" },
        },
      },
    },
  },
}
