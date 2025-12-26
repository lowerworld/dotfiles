return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local bufferline = require("bufferline")

      return vim.tbl_deep_extend("force", opts, {
        options = {
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
          },
          style_preset = {
            -- bufferline.style_preset.no_bold,
            bufferline.style_preset.no_italic,
          },
        },
      })
    end,
  },
  { "sindrets/diffview.nvim" },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = "",
        component_separators = "│",
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = true,
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            arrow = "",
          },
        },
      },
      lazygit = {
        config = {
          gui = {
            language = "en",
            showRandomTip = false,
            showCommandLog = false,
          },
          -- https://github.com/folke/snacks.nvim/issues/2582
          -- git = {
          --   pagers = {
          --     { pager = "delta --dark --paging=never" },
          --   },
          -- },
          disableStartupPopups = true,
        },
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
          },
          projects = {
            win = {
              input = {
                keys = {
                  ["<Enter>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
      terminal = {
        win = {
          position = "float",
        },
      },
    },
  },
}
