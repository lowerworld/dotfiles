return {
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
        [".oxlintrc.json"] = { glyph = "", hl = "MiniIconsCyan" },
        ["oxlint.config.ts"] = { glyph = "", hl = "MiniIconsCyan" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxlint = {
          root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
          settings = { typeAware = true },
        },
      },
    },
  },
}
