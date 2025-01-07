local has_telescope, telescope = pcall(require, "telescope")

local set = require("keymaps").set

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
    ["aerial"] = {
      show_columns = "both",
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

  set("n", "<leader>fx", function()
    builtin.colorscheme({
      enable_preview = true,
    })
  end, {
    desc = "colorscheme switcher",
  })

  set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
  set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
  set("n", "<leader>fc", builtin.command_history, { desc = "Cmd History" })

  set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
  set("n", "<leader>fb", function()
    builtin.buffers({
      ignore_current_buffer = true,
    })
  end, { desc = "Buffers" })

  set("n", "<leader>fj", builtin.jumplist, { desc = "Jump" })
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
