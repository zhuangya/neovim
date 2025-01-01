local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  buf_set_option("formatexpr", "v:lua.require'conform'.formatexpr()")

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter", "TextChanged", "InsertLeave" }, {
      callback = function()
        vim.lsp.inlay_hint.enable(true)
      end,
    })

    vim.keymap.set("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "toggle inlay hints" })

    vim.lsp.inlay_hint.enable(true)
  end

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = on_attach,
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_locale = "zh-cn", -- English : `en`, (Simplified) Chinese: `zh-cn`

        tsserver_file_preferences = {
          includeCompletionsForModuleExports = true,
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          -- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          -- includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          quotePreference = "auto",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "stevearc/conform.nvim",
        opts = {
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
          },
          formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            css = { "prettier" },
            typescript = { "prettier" },
          },
        },
      },
      "zapling/mason-conform.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-conform").setup()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}luv/library",
              },
            },
          },
        },
      })
    end,
  },
}
