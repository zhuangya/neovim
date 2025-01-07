local has_telescope, telescope = pcall(require, "telescope")

local set = vim.keymap.set

if has_telescope then
  local builtin = require("telescope.builtin")

  local extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
    ["frecency"] = {},
    ["project"] = {
      theme = "ivy",
    },
    ["egrepify"] = {},
    ["fzf"] = {
      fuzzy = true,
      case_mode = "smart_case",
      override_file_sorter = true,
      override_generic_sorter = true,
    },
  }

  local themes = require("telescope.themes")

  telescope.setup({
    defaults = vim.tbl_extend("force", themes.get_ivy(), {
      path_display = { truncate = 2 },
    }),
    extensions = extensions,
  })

  for ext in pairs(extensions) do
    telescope.load_extension(ext)
  end

  set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
  set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
  set("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
  set("n", "<leader>fe", "<cmd>Telescope egrepify<cr>", { desc = "EGrepIFY" })
  set("n", "<leader>fh", builtin.help_tags, { desc = "Help!" })
  set("n", "<leader>fp", function()
    telescope.extensions.project.project({
      display_type = "full",
    })
  end, { desc = "Project" })
  set(
    "n",
    "<leader>f.",
    '<cmd>Telescope frecency workspace=CWD path_display={"shorten"} theme=ivy<cr>',
    { desc = "recent files" }
  )
  -- lsp related mappings:
  set("n", "<leader>ld", builtin.lsp_definitions, { desc = "[LSP] definitions" })
  set("n", "<leader>lr", builtin.lsp_references, { desc = "[LSP] references" })
  set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "[LSP] document Symbols" })
end
