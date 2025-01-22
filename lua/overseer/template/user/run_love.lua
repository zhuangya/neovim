return {
  name = "Love It",
  builder = function()
    return {
      cmd = { "/Applications/love.app/Contents/MacOS/love" },
      args = { "." },
      components = { "open_output", "default" },
    }
  end,
  condition = {
    filetype = { "lua" },
  },
}
