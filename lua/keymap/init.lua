-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

-- usage of plugins
nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- Lsp
  { '<Leader>li', cmd('LspInfo'), opts(noremap, silent) },
  { '<Leader>ll', cmd('LspLog'), opts(noremap, silent) },
  { '<Leader>lr', cmd('LspRestart'), opts(noremap, silent) },
  { '<C-f>', cmd("lua require('lspsaga.action').smart_scroll_with_saga(1)"), opts(noremap, silent) },
  { '<C-b>', cmd("lua require('lspsaga.action').smart_scroll_with_saga(-1)"), opts(noremap, silent) },
  -- Lspsaga
  { '[e', cmd('Lspsaga diagnostic_jump_next'), opts(noremap, silent) },
  { ']e', cmd('Lspsaga diagnostic_jump_prev'), opts(noremap, silent) },
  { 'K', cmd('Lspsaga hover_doc'), opts(noremap, silent) },
  { 'ga', cmd('Lspsaga code_action'), opts(noremap, silent) },
  { 'gd', cmd('Lspsaga range_code_action'), opts(noremap, silent) },
  { 'gs', cmd('Lspsaga signature_help'), opts(noremap, silent) },
  { 'gr', cmd('Lspsaga rename'), opts(noremap, silent) },
  { 'gh', cmd('Lspsaga lsp_finder'), opts(noremap, silent) },
  -- Lspsaga floaterminal
  { '<A-d>', cmd('Lspsaga open_floaterm'), opts(noremap, silent) },
  { '<Leader>g', cmd('Lspsaga open_floaterm lazygit'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>e', cmd('NvimTreeToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
})
