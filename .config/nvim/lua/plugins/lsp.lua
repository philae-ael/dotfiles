return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "icons",
        },
      },
      inlay_hints = { enabled = true },
      autoformat = false,
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                  "--all-targets",
                  "--",
                  "-W",
                  "clippy:cargo",
                  "-W",
                  "clippy::pedantic",
                  "-W",
                  "clippy::all",
                },
              },
              inlayHints = {
                maxLength = 25,
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 15 },
                closureCaptureHints = { enable = true },
                -- closureReturnTypeHints = {enable = "never"},
                -- closureStyle = {enable = "impl_fn"},
                -- discriminantHints = {enable = "never"},
                -- expressionAdjustmentHints = {enable = "never", hideOutsideUnsafe = false, mode = "prefix"},
                -- lifetimeElisionHints = {enable = "never", useParameterNames=false},
                parameterHints = { enable = true },
                -- reborrowHints = { enable = "never"},
                renderColons = { enable = true },
                typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
              },
            },
            completion = { privateEditable = true },
            diagnostics = { experimental = true },
            hover = {
              memoryLayout = { niches = true },
            },
            rustc = {
              source = "discover",
            },
          },
        },
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    opts = { tools = { inlay_hints = { auto = false } } },
  },
}
