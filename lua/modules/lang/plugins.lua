-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local use = require('core.pack').register_plugin
local conf = require('modules.lang.config')

use({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter,
})

use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' })
