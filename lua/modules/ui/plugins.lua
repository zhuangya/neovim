-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local use = require('core.pack').register_plugin
local conf = require('modules.ui.config')

use({ 'wuelnerdotexe/vim-enfocado', config = conf.enfocado })

use({
  'goolord/alpha-nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('alpha').setup(require('alpha.themes.startify').config)
  end,
})

use({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

use({ 'akinsho/nvim-bufferline.lua', config = conf.nvim_bufferline, requires = 'kyazdani42/nvim-web-devicons' })
use({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns, requires = 'nvim-lua/plenary.nvim' })
use({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  requires = 'nvim-treesitter/nvim-treesitter',
  after = 'nvim-treesitter',
})
use({ 'sunjon/Shade.nvim' })
use({ 'nxvu699134/vn-night.nvim' })
use({
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end,
})
