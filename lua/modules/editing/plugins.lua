local use = require('core.pack').register_plugin

use({
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end,
})

use({
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})
