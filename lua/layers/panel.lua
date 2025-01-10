---@module 'snacks'
return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      graph_style = "kitty",
      process_spinner = true,
      kind = "split",
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Neogit",
      },

      {
        "<leader>gl",
        "<cmd>NeogitLogCurrent<cr>",
        desc = "Neogit Log Current",
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "user.lua_busted" },
    },
    keys = {
      {
        "<leader>or",
        "<cmd>OverseerRun<cr>",
        desc = "Overseer Run!",
      },
      {
        "<leader>oq",
        "<cmd>OverseerQuickAction<cr>",
        desc = "Overseer Quick Action",
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true, only_scope = true, only_current = true },
      input = { enabled = true },
      lazygit = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "notification history",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {},
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        {
          desc = "open parent directory",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "fdschmidt93/telescope-egrepify.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "piersolenski/telescope-import.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
