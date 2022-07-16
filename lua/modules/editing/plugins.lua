local plugin = require('core.pack').register_plugin

plugin({
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end,
})
