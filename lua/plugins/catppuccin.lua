require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  integrations = {
    cmp = true,
    telescope = { enabled = false },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = false,
    notify = false,
    noice = true,
    indent_blankline = {
      enabled = false, -- Disabled since we use snacks.indent
    },
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    snacks = {
      enabled = true,
      indentscope_color = "lavender",
    },
  },
}

-- set colorscheme - setup must be called before loading
vim.cmd.colorscheme "catppuccin"
