require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    telescope = {
      enabled = true,
    },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender",
      colored_indent_levels = true,
    },
  },
}
