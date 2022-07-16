-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'glepnir/zephyr-nvim', config = conf.zephyr })

plugin({
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
})

plugin({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({ 'akinsho/nvim-bufferline.lua', config = conf.nvim_bufferline, requires = 'kyazdani42/nvim-web-devicons' })
plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns, requires = 'nvim-lua/plenary.nvim' })
plugin({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  requires = 'nvim-treesitter/nvim-treesitter',
  after = 'nvim-treesitter',
})
plugin({ 'sunjon/Shade.nvim' })
plugin({ 'nxvu699134/vn-night.nvim' })
