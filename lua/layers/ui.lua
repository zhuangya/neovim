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
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            local desc = opts.desc or ""
            opts.buffer = bufnr
            opts.desc = "GitSign::" .. desc
            vim.keymap.set(mode, l, r, opts)
          end

          local function nav(direction)
            local diff_cmd = "[c"

            if direction == "next" then
              diff_cmd = "]c"
            end

            if vim.wo.diff then
              vim.cmd.normal({ diff_cmd, bang = true })
            else
              gitsigns.nav_hunk(direction)
            end
          end

          local prev = function()
            nav("prev")
          end

          local next = function()
            nav("next")
          end

          map("n", "(", prev, { desc = "nav to prev" })
          map("n", ")", next, { desc = "nav to next" })
        end,
      })
    end,
  },
}
