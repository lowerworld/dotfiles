return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!Equals sequence",
                "!GetAtt",
                "!If sequence",
                "!Join sequence",
                "!Or sequence",
                "!Ref",
                "!Select sequence",
                "!Sub",
                "!Sub sequence",
              },
            },
          },
        },
      },
    },
  },
}
