return {
  "tpope/vim-sleuth", -- detect indent
  require("layers.writing.lsp"),
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",

    build = "cargo build --release",

    opts = {
      sources = {
        cmdline = {},
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "markdown",
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        -- nerd_font_variant = 'mono'
      },
    },
  },
}
