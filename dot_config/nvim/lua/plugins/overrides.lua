return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                       Colorscheme                       │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
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
          always_show_bufferline = true,
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
    opts = function(_, opts)
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(mode)
            return mode:sub(1, 1):lower()
          end,
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
          icon = { "󰯙", color = "MiniIconsYellow" },
          on_click = function()
            require("triforce").show_profile()
          end,
        },
      })

      opts.sections.lualine_y = {
        { "location" },
      }

      opts.sections.lualine_z = {
        {
          function()
            return " "
          end,
          padding = 0,
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
    "nvim-mini/mini.ai",
    opts = function(_, opts)
      require("which-key").add({
        mode = { "o", "x" },
        { "a=", desc = "assignment" },
        { "i=", desc = "assignment" },
      })

      return vim.tbl_deep_extend("force", opts, {
        custom_textobjects = {
          ["="] = require("mini.ai").gen_spec.treesitter({
            a = "@assignment.outer",
            i = "@assignment.inner",
          }),
        },
      })
    end,
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".chezmoiignore.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc.js"] = { glyph = "", hl = "MiniIconsPurple" },
        ["compose.yaml"] = { glyph = "󰡨", hl = "MiniIconsYellow" },
        ["next.config.ts"] = { glyph = "", hl = "MiniIconsGrey" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["pnpm-lock.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
        ["pnpm-workspace.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        Brewfile = { glyph = "", hl = "MiniIconsOrange" },
        README = { glyph = "󰈙", hl = "MiniIconsYellow" },
        ["README.md"] = { glyph = "󰈙", hl = "MiniIconsYellow" },
        ["README.txt"] = { glyph = "󰈙", hl = "MiniIconsYellow" },
      },
      filetype = {
        json = { glyph = "", hl = "MiniIconsAzure" },
        ["markdown.mdx"] = { glyph = "󰍔", hl = "MiniIconsBlue" },
        template = { glyph = "", hl = "MiniIconsGrey" },
        yaml = { glyph = "", hl = "MiniIconsRed" },
        zsh = { glyph = "", hl = "MiniIconsGreen" },
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
            return vim.o.columns >= 135 and "default" or "vertical"
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
        win = { style = "float" },
      },
    },
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         Extras                          │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- formatting.biome
      if LazyVim.has_extra("formatting.biome") then
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

      -- formatting.prettier
      if LazyVim.has_extra("formatting.prettier") then
        vim.g.lazyvim_prettier_needs_config = true
      end
    end,
  },
  -- coding.blink
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
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
}
