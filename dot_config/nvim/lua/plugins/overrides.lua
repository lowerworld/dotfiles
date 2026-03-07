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
        local util = require("tokyonight.util")

        hl.CursorLineNr = { fg = color.green1, bg = color.bg_highlight }
        hl.WinSeparator = { fg = util.lighten(color.bg_dark, 0.9) }

        hl.SnacksPickerInputBorder = { link = "SnacksPickerBorder" }
        hl.SnacksPickerInputTitle = { link = "SnacksPickerTitle" }
      end,
    },
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         Editor                          │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      extraRgArgs = "-.",
    },
  },
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
          always_show_bufferline = not vim.list_contains({ "gitcommit", "gitrebase" }, vim.bo.filetype),
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
          ["pnpm-lock.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
          ["pnpm-workspace.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
          ["postcss.config.js"] = { glyph = "", hl = "MiniIconsRed" },
          ["tsconfig.json"] = { glyph = "󱁼", hl = "MiniIconsAzure" },
          ["tsconfig.build.json"] = { glyph = "󱁼", hl = "MiniIconsAzure" },
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
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         Extras                          │
  -- ╰─────────────────────────────────────────────────────────╯
  -- coding.blink
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  -- formatting.biome, formatting.prettier
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      if LazyVim.has_extra("formatting.biome") then
        ---@param ctx ConformCtx
        opts.formatters.biome.condition = function(_, ctx)
          local config_file = vim.fs.find(
            { "biome.json", "biome.jsonc" },
            { path = ctx.filename, upward = true, stop = vim.uv.os_homedir() }
          )[1]

          if config_file == nil then
            return false
          end

          local ok, enabled = pcall(function()
            local config = vim.json.decode(table.concat(vim.fn.readfile(config_file), "\n"))
            return vim.tbl_get(config, "formatter", "enabled") ~= false
          end)

          return ok and enabled
        end
      end

      if LazyVim.has_extra("formatting.prettier") then
        vim.g.lazyvim_prettier_needs_config = true
      end
    end,
  },
  -- lang.docker
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.docker") then
        return vim.tbl_deep_extend("force", opts, {
          servers = {
            docker_compose_language_service = {
              enabled = false,
            },
          },
        })
      end
    end,
  },
  -- lang.markdown
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      if LazyVim.has_extra("lang.markdown") then
        opts.linters_by_ft.markdown = {}
      end
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      latex = { enabled = false },
    },
  },
  -- lang.typescript
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.typescript") then
        return vim.tbl_deep_extend("force", opts, {
          servers = {
            vtsls = {
              settings = {
                typescript = {
                  inlayHints = {
                    variableTypes = { enabled = true },
                  },
                },
              },
            },
          },
        })
      end
    end,
  },
}
