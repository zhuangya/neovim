return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd([[colorscheme eldritch]])
    end,
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
      local set = require("keymaps").set

      gitsigns.setup({
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            local desc = opts.desc or ""
            opts.buffer = bufnr
            opts.desc = "GitSign::" .. desc
            set(mode, l, r, opts)
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

          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "hunk blame" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "diff this" })
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "reset hunk" })
        end,
      })
    end,
  },
}
