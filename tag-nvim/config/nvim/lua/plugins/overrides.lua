---@type LazyPluginSpec[]
return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                           UI                            │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<C-PageUp>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<C-PageDown>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
          },
          style_preset = {
            require("bufferline").style_preset.no_italic,
          },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local lsp_clients = {}

      lsp_clients.component = function()
        local clients = vim
          .iter(vim.lsp.get_clients({ bufnr = 0 }))
          :map(function(client)
            return client.name
          end)
          :totable()

        if vim.tbl_isempty(clients) then
          return ""
        end

        local client = table.remove(clients, 1)

        return table.concat({
          client,
          not vim.tbl_isempty(clients) and "+" .. vim.tbl_count(clients) or nil,
        }, ",")
      end

      lsp_clients.on_click = function()
        local clients = vim
          .iter(vim.lsp.get_clients({ bufnr = 0 }))
          :enumerate()
          :map(function(i, client)
            return ("%d. %s"):format(i, client.name)
          end)
          :totable()

        LazyVim.info(clients, { title = ("LSP Clients (%d)"):format(vim.tbl_count(clients)) })
      end

      table.insert(opts.sections.lualine_x, {
        lsp_clients.component,
        icon = "",
        on_click = lsp_clients.on_click,
      })

      table.insert(opts.sections.lualine_y, 1, {
        "fileformat",
        icons_enabled = false,
      })

      return vim.tbl_deep_extend("force", opts, {
        options = {
          section_separators = "",
          component_separators = "⋮",
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
        ["compose.yaml"] = { glyph = "󰡨", hl = "MiniIconsYellow" },
      },
      filetype = {
        json = { glyph = "", hl = "MiniIconsAzure" },
        yaml = { glyph = "", hl = "MiniIconsRed" },
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
        sources = {
          explorer = {
            hidden = true,
            win = {
              input = {
                keys = {
                  ["<Esc>"] = { "<Nop>", mode = { "n" } },
                },
              },
              list = {
                keys = {
                  ["<Esc>"] = { "<Nop>", mode = { "n" } },
                },
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
  -- formatting.biome
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      if vim.tbl_get(opts, "formatters", "biome") ~= nil then
        opts.formatters.biome.condition = function()
          local config_file = vim.fs.find({ "biome.json", "biome.jsonc" }, { path = LazyVim.root.get() })[1]

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
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  -- lang.typescript
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".prettierrc.js"] = { glyph = "", hl = "MiniIconsPurple" },
        ["pnpm-lock.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
        ["pnpm-workspace.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
}
