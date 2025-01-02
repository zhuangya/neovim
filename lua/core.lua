local M = {}

M.keymap = vim.keymap

local basic_setup = function()
  local g = vim.g
  local opt = vim.opt
  -- set spacebar to leader.
  g.mapleader = " "
  g.maplocalleader = " "

  -- Cursor shape
  opt.gcr = {
    "i-c-ci-ve:blinkoff500-blinkon500-block-TermCursor",
    "n-v:block-Curosr/lCursor",
    "o:hor50-Curosr/lCursor",
    "r-cr:hor20-Curosr/lCursor",
  }

  opt.swapfile = false
  opt.laststatus = 3
  opt.number = true
  opt.showmode = false
  opt.clipboard = "unnamedplus"
  opt.splitright = true
  opt.splitbelow = true
  opt.list = true
  opt.inccommand = "split"
  opt.cursorline = true
  opt.scrolloff = 8
  opt.hlsearch = true
  opt.signcolumn = "yes:1"
end

local ensure_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  end ---@diagnostic disable-next-line: undefined-field
  vim.opt.rtp:prepend(lazypath)
end

M.start = function()
  vim.loader.enable()

  basic_setup()

  ensure_lazy()

  require("lazy").setup("layers", {
    change_detection = {
      notify = false,
    },
    checker = { enabled = true },
  })
end

return M
