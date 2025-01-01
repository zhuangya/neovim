return {
  {
    "lmantw/themify.nvim",
    lazy = false,
    priority = 999,
    opts = {
      "folke/tokyonight.nvim",
      "wildcharm",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
