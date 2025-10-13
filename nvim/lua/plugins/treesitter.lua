local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  -- parsers are installed by nix
  ensure_installed = {},
  auto_install = false,
  -- enable syntax highlighting
  highlight = { enable = true },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}
