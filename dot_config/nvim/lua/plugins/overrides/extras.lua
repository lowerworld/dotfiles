return {
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
  -- lang.typescript
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if LazyVim.has_extra("lang.typescript") then
        return vim.tbl_deep_extend("force", opts, {
          servers = {
            vtsls = {
              settings = {
                javascript = {
                  format = { enable = false },
                },
                typescript = {
                  format = { enable = false },
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
