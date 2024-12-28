return {
  'tpope/vim-sleuth', -- detect indent
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    build = 'cargo build --release',

    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        -- nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}
