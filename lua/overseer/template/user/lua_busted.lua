return {
  name = "Lua Busted Test",
  builder = function()
    local file = vim.fn.expand("%:.")
    return {
      cmd = { "busted" },
      args = { file },
      components = { "open_output", "default" },
    }
  end,
  condition = {
    filetype = { "lua" },
  },
}
