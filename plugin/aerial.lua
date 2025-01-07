local has_aerial, aerial = pcall(require, "aerial")
local set = require("keymaps").set

if has_aerial then
  aerial.setup({
    backends = {
      "lsp",
      "treesitter",
      "markdown",
      "asciidoc",
      "man",
    },
    default_direction = "prefer_right",

    on_attach = function(bufnr)
      set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr })
      set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr })
    end,
  })

  set("n", "<leader>a", "<cmd>AerialToggle!<cr>", { desc = "Toggle Aerial" })
end
