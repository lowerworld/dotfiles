return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                       Colorscheme                       │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_highlights = function(hl, color)
        hl.CursorLineNr = { fg = color.green1, bg = color.bg_highlight }
        hl.WinSeparator = { fg = require("tokyonight.util").lighten(color.bg_dark, 0.85), bg = color.bg }

        hl.BlinkCmpMenuBorder = { link = "WinSeparator" }
        hl.BlinkCmpDocBorder = { link = "WinSeparator" }

        hl.NoicePopupBorder = { link = "WinSeparator" }

        hl.SnacksPickerInputBorder = { link = "SnacksPickerBorder" }
        hl.SnacksPickerInputTitle = { link = "SnacksPickerTitle" }
      end,
    },
  },
}
