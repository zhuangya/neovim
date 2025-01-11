return {
  name = "Lua Busted Test",
  builder = function()
    return {
      cmd = { "busted" },
      cwd = vim.fn.expand("%:p:h"),
      components = { "open_output", "default" },
    }
  end,
  condition = {
    filetype = { "lua" },
  },
}
