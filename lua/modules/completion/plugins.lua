-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local use = require('core.pack').register_plugin
local conf = require('modules.completion.config')

use({
  'neovim/nvim-lspconfig',
  config = conf.nvim_lsp,
})

use({
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup({
      ensure_installed = { 'sumneko_lua', 'rust_analyzer', 'tsserver' },
    })
  end,
})

use({
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup()
  end,
})

use({
  'hrsh7th/nvim-cmp',
  -- event = 'InsertEnter',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
  },
})

use({ 'L3MON4D3/LuaSnip', event = 'InsertEnter', config = conf.lua_snip })
