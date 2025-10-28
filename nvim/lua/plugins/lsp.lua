local lspconfig = require("lspconfig")

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                enable = false,
                typeHints = false,
                parameterHints = false,
              },
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  "target",
                },
              },
            },
          },
        },
        tailwindcss = {},
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          opts.filetypes = { "css", "scss", "typescript", "analog", "ag", "astro", "typescriptreact" }
        end,
      },
    },
  },
}
