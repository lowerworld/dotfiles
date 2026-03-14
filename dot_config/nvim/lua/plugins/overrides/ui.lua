return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                           UI                            │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      { "<C-PageUp>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<C-PageDown>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "<C-M-PageUp>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
      { "<C-M-PageDown>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next" },

      { "<S-Left>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<S-Right>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "<M-S-Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
      { "<M-S-Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next" },
    },
    opts = function(_, opts)
      local bufferline = require("bufferline")

      return vim.tbl_deep_extend("force", opts, {
        options = {
          always_show_bufferline = not vim.env.NVIM,
          groups = {
            items = {
              bufferline.groups.builtin.pinned:with({ icon = "" }),
            },
          },
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
          },
          style_preset = {
            bufferline.style_preset.no_italic,
          },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "gisketch/triforce.nvim" },
    opts = function(_, opts)
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(mode)
            return mode:sub(1, 1):lower()
          end,
        },
      }

      opts.sections.lualine_b = {
        {
          require("plugins.lualine.components.branch"),
          icon = "",
        },
      }

      vim.list_extend(opts.sections.lualine_x, {
        {
          require("plugins.lualine.components.formatters"),
          icon = {
            "",
            color = function()
              return LazyVim.format.enabled() and "MiniIconsCyan" or nil
            end,
          },
          on_click = function()
            LazyVim.format.info()
          end,
        },
        LazyVim.has_extra("editor.overseer") and {
          "overseer",
          on_click = function()
            require("overseer.window").toggle()
          end,
        } or nil,
        {
          function()
            return require("triforce.lualine").level({
              bar = {
                chars = { empty = "%#lualine_c_inactive#░%#lualine_c_normal#" },
                length = 10,
              },
              show = { percent = true },
            })
          end,
          cond = function()
            return require("triforce.config").config.enabled
          end,
          icon = { "󰯙", color = "MiniIconsYellow" },
          on_click = function()
            require("triforce").show_profile()
          end,
        },
      })

      opts.sections.lualine_y = {
        { "location", icon = "󱝴" },
      }

      opts.sections.lualine_z = {
        {
          function()
            return vim.tbl_count(vim
              .iter(vim.api.nvim_list_bufs())
              :filter(function(id)
                return vim.bo[id].buflisted and vim.bo[id].buftype ~= "nofile"
              end)
              :totable())
          end,
        },
      }

      return vim.tbl_deep_extend("force", opts, {
        options = {
          section_separators = "",
          component_separators = "%#lualine_c_inactive#󰇝%#lualine_c_normal#",
        },
      })
    end,
  },
  {
    "nvim-mini/mini.icons",
    opts = function(_, opts)
      vim.filetype.add({
        filename = {
          [".env"] = "sh.dotenv",
          ["compose.yaml"] = "yaml.docker-compose",
        },
        pattern = {
          ["%.env%.[%w_.-]+"] = "sh.dotenv",
          ["[%w_.-]*zsh[%w_.-]*%.tmpl"] = "zsh.chezmoitmpl",
        },
      })

      return vim.tbl_deep_extend("force", opts, {
        directory = {
          [".vscode"] = { glyph = "", hl = "MiniIconsBlue" },
        },
        extension = {
          hpp = { glyph = "󰽭", hl = "MiniIconsPurple" },
        },
        file = {
          [".chezmoiignore.tmpl"] = { glyph = "", hl = "MiniIconsBlue" },
          [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
          [".prettierrc.js"] = { glyph = "", hl = "MiniIconsPurple" },
          ["init.lua"] = { glyph = "", hl = "MiniIconsGreen" },
          ["next.config.ts"] = { glyph = "", hl = "MiniIconsGrey" },
          ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
          ["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
          ["pnpm-lock.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
          ["pnpm-workspace.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
          ["postcss.config.js"] = { glyph = "", hl = "MiniIconsRed" },
          ["tsconfig.json"] = { glyph = "󱁼", hl = "MiniIconsAzure" },
          ["tsconfig.build.json"] = { glyph = "󱁼", hl = "MiniIconsAzure" },
          ["turbo.json"] = { glyph = "", hl = "MiniIconsGrey" },
          Brewfile = { glyph = "", hl = "MiniIconsOrange" },
          README = { glyph = "󰈙", hl = "MiniIconsYellow" },
          ["README.md"] = { glyph = "󰈙", hl = "MiniIconsYellow" },
          ["README.txt"] = { glyph = "󰈙", hl = "MiniIconsYellow" },
        },
        filetype = {
          cmake = { glyph = "", hl = "MiniIconsBlue" },
          cpp = { glyph = "", hl = "MiniIconsAzure" },
          json = { glyph = "", hl = "MiniIconsAzure" },
          ["markdown.mdx"] = { glyph = "󰍔", hl = "MiniIconsBlue" },
          sh = { glyph = "", hl = "MiniIconsGreen" },
          ["sh.dotenv"] = { glyph = "", hl = "MiniIconsYellow" },
          template = { glyph = "", hl = "MiniIconsGrey" },
          toml = { glyph = "󰅪", hl = "MiniIconsOrange" },
          yaml = { glyph = "", hl = "MiniIconsRed" },
          zsh = { glyph = "", hl = "MiniIconsGreen" },
          ["zsh.chezmoitmpl"] = { glyph = "", hl = "MiniIconsGreen" },
        },
        use_file_extension = function(ext)
          return not vim.list_contains({ "tmpl", "yaml" }, ext)
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      status = {
        command = {
          cond = function()
            return false
          end,
        },
      },
    },
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
          disableStartupPopups = true,
          ---@see https://github.com/folke/snacks.nvim/issues/2582
          -- git = {
          --   pagers = {
          --     { pager = "delta --dark --paging=never" },
          --   },
          -- },
          gui = {
            language = "en",
            showCommandLog = false,
          },
        },
      },
      picker = {
        layout = {
          preset = function()
            return vim.o.columns >= 145 and "default" or "vertical"
          end,
        },
        layouts = {
          default = {
            layout = {
              height = 0.9,
            },
          },
          vertical = {
            layout = {
              backdrop = true,
              width = 0.9,
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            win = {
              input = {
                keys = { ["<Esc>"] = { "<Nop>", mode = { "n" } } },
              },
              list = {
                keys = { ["<Esc>"] = { "<Nop>", mode = { "n" } } },
              },
            },
          },
          files = { hidden = true },
          grep = { hidden = true },
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
          style = "float",
          keys = {
            hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = { "t", "n" } },
          },
        },
      },
    },
  },
}
