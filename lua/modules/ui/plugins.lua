-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local use = require('core.pack').register_plugin
local conf = require('modules.ui.config')

use({ 'olimorris/onedarkpro.nvim', config = conf.onedarkpro })
use({ 'nvim-lualine/lualine.nvim', config = conf.lualine, requires = { 'kyazdani42/nvim-web-devicons', opt = true } })

use({ 'folke/todo-comments.nvim', config = conf.todo })
use({ 'folke/trouble.nvim', config = conf.trouble })

use({
  'goolord/alpha-nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = conf.alpha,
})

use({
  'kyazdani42/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
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
  config = conf.which_key,
})

use({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup()
  end,
})
