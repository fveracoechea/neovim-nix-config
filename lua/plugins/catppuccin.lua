require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  integrations = {
    -- Disabled telescope since we use snacks.picker
    telescope = {
      enabled = false,
    },
    which_key = true,
    lsp_trouble = true,
    nvim_surround = false, -- Disabled since we use mini.surround
    notify = false, -- Disabled since we use snacks.notifier
    noice = true,
    indent_blankline = {
      enabled = false, -- Disabled since we use snacks.indent
    },
    -- Add snacks integrations if available
    mini = true, -- For mini.nvim integration
  },
}

-- set colorscheme - setup must be called before loading
vim.cmd.colorscheme "catppuccin"
