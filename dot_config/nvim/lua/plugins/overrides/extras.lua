return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         Extras                          │
  -- ╰─────────────────────────────────────────────────────────╯
  -- coding.blink
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local function filter_by_language_for_range()
        local exclude = { "graphql" }

        local ok, parser = pcall(vim.treesitter.get_parser)

        if ok and parser then
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          return not vim.list_contains(exclude, parser:language_for_range({ row - 1, col, row - 1, col }):lang())
        end

        return true
      end

      return vim.tbl_deep_extend("force", opts, {
        completion = {
          documentation = {
            window = {
              border = "rounded",
            },
          },
          ghost_text = {
            enabled = filter_by_language_for_range,
          },
          list = {
            selection = {
              auto_insert = false,
              preselect = filter_by_language_for_range,
            },
          },
          menu = {
            border = "rounded",
            max_height = 14,
          },
        },
      })
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
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
  -- lang.json
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.json") then
        return vim.tbl_deep_extend("force", opts, {
          servers = {
            jsonls = {
              init_options = {
                provideFormatter = false,
              },
            },
          },
        })
      end
    end,
  },
  -- lang.typescript.biome, formatting.prettier
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.typescript.biome") then
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
  -- lang.typescript.tsgo
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.typescript.tsgo") then
        return vim.tbl_deep_extend("force", opts, {
          servers = {
            tsgo = {
              settings = {
                typescript = {
                  inlayHints = {
                    variableTypes = { enabled = true },
                  },
                },
              },
              on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
            },
          },
        })
      end
    end,
  },
  -- lang.typescript.vtsls
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.typescript.vtsls") then
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
              on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
            },
          },
        })
      end
    end,
  },
}
