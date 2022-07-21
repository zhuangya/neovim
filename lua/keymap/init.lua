local keymap = require('core.keymap')
local nmap, xmap = keymap.nmap, keymap.xmap
local noremap = keymap.noremap
local opts = keymap.new_opts

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

local wk = require('which-key')

-- with <leader>:
wk.register({
  p = {
    name = 'Packer',
    u = { '<cmd>PackerUpdate<cr>', 'Packer Update' },
    i = { '<cmd>PackerInstall<cr>', 'Packer Install' },
    c = { '<cmd>PackerCompile<cr>', 'Packer Compile' },
    s = { '<cmd>PackerSync<cr>', 'Packer Sync' },
  },
  l = {
    name = 'LSP',
    i = { '<cmd>LspInfo<cr>', 'Lsp Info' },
    l = { '<cmd>LspLog<cr>', 'Lsp Log' },
    x = { '<cmd>LspRestart<cr>', 'Lsp Restart' },
    r = {
      function()
        vim.lsp.buf.rename()
      end,
      'Rename',
    },
    a = {
      function()
        vim.lsp.buf.code_action()
      end,
      'Code Action',
    },
    f = {
      function()
        vim.lsp.buf.format()
      end,
      'Format',
    },
    k = {
      function()
        vim.lsp.buf.signature_help()
      end,
      'Signature'
    },
  },
  n = {
    name = 'NeoFormat',
    f = { '<cmd>Neoformat<cr>', 'NeoFormat' },
  },
  t = {
    name = 'Nvim Tree',
    t = { '<cmd>NvimTreeToggle<cr>', 'Nvim Tree' },
    f = { '<cmd>NvimTreeFindFile<cr>', 'Nvim Tree Find File' },
  },
  f = {
    name = 'Files!',
    f = { '<cmd>Telescope find_files<cr>', 'file' },
    g = { '<cmd>Telescope git_files<cr>', 'Git Files' },
    m = { '<cmd>Telescope oldfiles<cr>', 'Recent Files' },
  },
  s = {
    name = 'Search',
    l = { '<cmd>Telescope live_grep<cr>', 'live grep' },
    s = { '<cmd>Telescope grep_string<cr>', 'grep string' },
  },
  x = {
    name = 'Troubles',
    t = { '<cmd>TodoTrouble<cr>', 'Todo Trouble' },
    x = { '<cmd>TroubleToggle<cr>', 'Trouble Toggle' },
    w = { '<cmd>TroubleToggle workspace_diagnostic<cr>', 'Trouble Toggle for Workspace' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Trouble Toggle for Document' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'Trouble Toggle in quickfix' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'Trouble Toggle in loclist' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'Trouble Toggle[LSP References]' },
  },
}, { prefix = '<leader>' })

-- without <leader>:
wk.register({
  ['[d'] = {
    function()
      vim.diagnostic.goto_prev()
    end,
    'Previous Diagnostic',
  },
  [']d'] = {
    function()
      vim.diagnostic.goto_next()
    end,
    'Next Diagnostic',
  },
  g = {
    d = {
      function()
        vim.lsp.buf.definition()
      end,
      'Go To Definition',
    },
    i = {
      function()
        vim.lsp.buf.implementation()
      end,
      'Implementation',
    },
  },
})

wk.register({
  ['K'] = {
    function()
      vim.lsp.buf.hover()
    end,
    'Hover',
  },
  ['D'] = {
    function()
      vim.lsp.buf.type_definition()
    end,
    'Type Def',
  },
})
