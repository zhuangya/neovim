local M = {}

M.set = vim.keymap.set
M.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "source this file" })

return M
