-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local use = require('core.pack').register_plugin
local conf = require('modules.tools.config')

use({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim', opt = true },
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
  },
})

use({
  'sbdchd/neoformat',
  cmd = 'Neoformat',
})

use({
  'zhuangya/im-select.nvim',
  config = function()
    require('im_select').setup()
  end,
})
