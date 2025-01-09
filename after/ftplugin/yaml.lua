local path = vim.fn.expand("%:p:~:.:h")

if string.find(path, ".github/workflows") then
  vim.api.nvim_set_option_value("filetype", "yamlghaction", {})
end
