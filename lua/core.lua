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
  local stat = vim.loop.fs_stat(lazypath)
  if not stat then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  end
  vim.opt.rtp:prepend(lazypath)
end

local auto_chdir = function()
  -- auto change to root directory
  -- source: https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/

  -- Array of file names indicating root directory. Modify to your liking.
  local root_names = { ".git", "Makefile", "gleam.toml" }

  -- Cache to use for speed up (at cost of possibly outdated results)
  local root_cache = {}

  local set_root = function()
    -- Get directory path to start search from
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
      return
    end
    path = vim.fs.dirname(path)

    -- Try cache and resort to searching upward for root directory
    local root = root_cache[path]
    if root == nil then
      local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
      if root_file == nil then
        return
      end
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
    end

    -- Set current directory
    vim.fn.chdir(root)
  end

  local root_augroup = vim.api.nvim_create_augroup("MyAutoRoot", {})
  vim.api.nvim_create_autocmd("BufEnter", { group = root_augroup, callback = set_root })
end

M.start = function()
  vim.loader.enable()

  basic_setup()

  ensure_lazy()

  auto_chdir()

  require("lazy").setup("layers", {
    change_detection = {
      notify = false,
    },
    checker = { enabled = true },
  })
end

return M
