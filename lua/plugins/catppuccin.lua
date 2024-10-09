local catppuccin = require "catppuccin"

catppuccin.setup {
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    which_key = true,
    lsp_trouble = true,
    nvim_surround = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = true,
    },
    telescope = {
      enabled = false,
    },
  },
}
