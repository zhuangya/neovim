local M = {}

M.set = vim.keymap.set

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  M.set(mode, lhs, rhs, opts)
end

map("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "source this file" })

return M
