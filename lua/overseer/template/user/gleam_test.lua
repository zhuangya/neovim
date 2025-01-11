return {
  name = "Gleam Test",
  builder = function()
    return {
      cmd = { "gleam" },
      args = { "test" },
      cwd = vim.fn.expand("%:p:h") .. "/../",
      components = { "open_output", "default" },
    }
  end,
  condition = {
    filetype = { "gleam" },
  },
}
