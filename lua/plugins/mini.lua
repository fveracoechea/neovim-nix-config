-- Mini.nvim configuration - consolidate multiple plugins into mini modules
-- Each module is independent and can be configured separately

require("mini.sessions").setup {
  directory = vim.fn.stdpath "data" .. "/sessions",
  file = "",
}

require("mini.completion").setup {}
require("mini.pairs").setup {}
require("mini.surround").setup {}
require("mini.comment").setup {}
require("mini.statusline").setup {}
require("mini.diff").setup {}

local gen_loader = require("mini.snippets").gen_loader

require("mini.snippets").setup {
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file "~/.config/nvim/snippets/global.json",
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
}

require("mini.icons").setup {
  style = "glyph",
}

MiniIcons.tweak_lsp_kind()
