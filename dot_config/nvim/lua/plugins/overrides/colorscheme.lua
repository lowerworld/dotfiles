return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                       Colorscheme                       │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      dim_inactive = true,
      on_highlights = function(hl, color)
        hl.CursorLineNr = { fg = color.green1, bg = color.bg_highlight }
        hl.WinSeparator = { fg = require("tokyonight.util").lighten(color.bg_dark, 0.85) }

        hl.SnacksPickerInputBorder = { link = "SnacksPickerBorder" }
        hl.SnacksPickerInputTitle = { link = "SnacksPickerTitle" }
      end,
    },
  },
}
