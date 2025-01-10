return {
  name = "Exercism Submit",
  builder = function()
    local file = vim.fn.expand("%:.")
    return {
      cmd = { "exercism" },
      args = { "submit" },
      -- TODO: maybe parse the output and open the exercism url?
      cwd = vim.fn.expand("%:p:h"),
      components = { "open_output", "default" },
    }
  end,
  condition = {
    callback = function()
      if string.find(vim.fn.expand("%:p"), "exercism") then
        return true
      end
      return false
    end,
  },
}
