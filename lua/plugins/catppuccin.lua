require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = "rounded",
  },
  integrations = {
    telescope = {
      enabled = true,
    },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = true,
    notify = true,
    noice = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender",
      colored_indent_levels = true,
    },
  },
}

-- set colorscheme - setup must be called before loading
vim.cmd.colorscheme "catppuccin"
