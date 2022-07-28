-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

-- config server in this function
function config.nvim_lsp()
  local api = vim.api
  local lspconfig = require('lspconfig')
  local format = require('modules.completion.format')
  -- require('nvim-lsp-installer').setup({})

  -- local servers = {
  --   -- web:
  --   'cssls',
  --   'eslint',
  --   'graphql',
  --   'html',
  --   'jsonls',
  --   'tailwindcss',
  --   'tsserver',
  --   'zk',
  --
  --   -- other langs:
  --   'rust_analyzer',
  --   'sumneko_lua',
  --   'clangd',
  --   'pyright',
  -- }

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd([[edit]])
  end

  function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd('edit ' .. path)
  end

  vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
  vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

  local signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = 'ﴞ ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = {
      source = true,
    },
  })

  local enhance_attach = function(client, bufnr)
    if client.server_capabilities.document_formatting then
      format.lsp_before_save()
    end
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  -- for _, lsp in ipairs(servers) do
  --   lspconfig[lsp].setup({
  --     on_attach = enhance_attach,
  --   })
  -- end

  -- lspconfig.sumneko_lua.setup({
  --   settings = {
  --     Lua = {
  --       runtime = {
  --         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
  --         version = 'LuaJIT',
  --       },
  --       diagnostics = {
  --         -- Get the language server to recognize the `vim` global
  --         globals = { 'vim' },
  --       },
  --       workspace = {
  --         -- Make the server aware of Neovim runtime files
  --         library = vim.api.nvim_get_runtime_file('', true),
  --       },
  --       -- Do not send telemetry data containing a randomized but unique identifier
  --       telemetry = {
  --         enable = false,
  --       },
  --     },
  --   },
  -- })

  lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      enhance_attach(client, bufnr)
    end,
  })
end

function config.nvim_cmp()
  local cmp = require('cmp')

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local lspkind_icons = {
          Text = '',
          Method = '',
          Function = '',
          Constructor = ' ',
          Field = '',
          Variable = '',
          Class = '',
          Interface = '',
          Module = '硫',
          Property = '',
          Unit = ' ',
          Value = '',
          Enum = ' ',
          Keyword = 'ﱃ',
          Snippet = ' ',
          Color = ' ',
          File = ' ',
          Reference = 'Ꮢ',
          Folder = ' ',
          EnumMember = ' ',
          Constant = ' ',
          Struct = ' ',
          Event = '',
          Operator = '',
          TypeParameter = ' ',
        }
        local meta_type = vim_item.kind
        -- load lspkind icons
        vim_item.kind = lspkind_icons[vim_item.kind] .. ''

        vim_item.menu = ({
          buffer = ' Buffer',
          nvim_lsp = meta_type,
          path = ' Path',
          luasnip = ' LuaSnip',
        })[entry.source.name]

        return vim_item
      end,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.close(),
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  })
  vim.cmd('hi CmpFloatBorder guifg=red')
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.lsp_installer()
  -- require('nvim-lsp-installer').setup({})
end

return config
