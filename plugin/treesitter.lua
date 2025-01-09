local has_treesitter, _ = pcall(require, "nvim-treesitter")

if has_treesitter then
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    auto_install = true,
    ensure_installed = { "typescript", "lua" },
    ignore_install = {},
    modules = {},
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })

  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end
