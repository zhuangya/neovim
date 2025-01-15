local set = require("keymaps").set

local on_attach = function(client, bufnr)
  local function buf_set_option(name, value, opts)
    opts = opts or {}
    opts.buf = bufnr
    vim.api.nvim_set_option_value(name, value, opts)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  buf_set_option("formatexpr", "v:lua.require'conform'.formatexpr()")

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter", "TextChanged", "InsertLeave" }, {
      callback = function()
        vim.lsp.inlay_hint.enable(true)
      end,
    })

    set("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "toggle inlay hints" })

    vim.lsp.inlay_hint.enable(true)
  end

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }

  set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  set("i", "<a-cr>", vim.lsp.buf.code_action, opts) -- same binding, just bound to "alt+enter" like in intellij

  set("n", "gD", vim.lsp.buf.declaration, opts)
  set("n", "gd", vim.lsp.buf.definition, opts)
  set("n", "K", vim.lsp.buf.hover, opts)
  set("n", "gi", vim.lsp.buf.implementation, opts)
  set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  set("n", "<space>rn", vim.lsp.buf.rename, opts)
  set("n", "gr", vim.lsp.buf.references, opts)
  set("n", "<space>e", vim.diagnostic.open_float, opts)
  set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)
  set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)
  set("n", "<space>q", vim.diagnostic.setloclist, opts)
end

return {
  {
    "mfussenegger/nvim-lint",
  },
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      code_lenses = true,
      autocmd = { enabled = true },
      number = { enabled = true },
    },
  },
  {
    "dmmulroy/tsc.nvim",
    opts = {
      use_diagnostics = false,
    },
  },
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

      lspconfig.gleam.setup({
        on_attach = on_attach,
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "5.4",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- library = vim.api.nvim_get_runtime_file("", true),
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
            },
          },
        },
      })
    end,
  },
}
