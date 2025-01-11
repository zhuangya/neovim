local has_lint, lint = pcall(require, "lint")

if has_lint then
  lint.linters_by_ft = {
    yamlghaction = { "actionlint" },
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      lint.try_lint()
      -- lint.try_lint("cspell")
    end,
  })
end
