local supported_ft = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "json5",
  "yaml",
  "toml",
  "html",
  "angular",
  "vue",
  "css",
  "scss",
  "less",
  "markdown",
  "markdown.mdx",
  "graphql",
  "ember",
  "handlebars",
}

return {
  desc = "Oxfmt is a high-performance formatter for the JavaScript ecosystem.",
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      vim.iter(supported_ft):each(function(ft)
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end)

      return vim.tbl_deep_extend("force", opts, {
        formatters = {
          oxfmt = {
            require_cwd = vim.g.lazyvim_oxfmt_needs_config ~= false,
          },
        },
      })
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
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxfmt = { enabled = false },
      },
    },
  },
}
