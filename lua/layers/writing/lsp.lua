return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()

    local handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup {}
      end,
      ["lua_ls"] = function()
        local lspconfig = require('lspconfig')
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim"}
              }
            }
          }
        }
      end
    }

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "jsonls",
        "tailwindcss",
        "ts_ls"
      },
      automatic_installation = true,
      handlers = handlers
    })

  end,
}
