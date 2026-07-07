return {
  desc = "Oxlint is a high-performance linter for JavaScript and TypeScript built on the Oxc compiler stack.",
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "oxlint" },
    },
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".oxlintrc.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["oxlint.config.ts"] = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxlint = {
          root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
        },
      },
    },
  },
}
