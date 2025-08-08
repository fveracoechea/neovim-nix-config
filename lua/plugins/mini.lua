-- Mini.nvim configuration - consolidate multiple plugins into mini modules
-- Each module is independent and can be configured separately

require("mini.icons").setup {
  style = "glyph",
}

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

require("mini.completion").setup {}
require("mini.pairs").setup {}
require("mini.surround").setup {}
require("mini.comment").setup {}
require("mini.sessions").setup {}
require("mini.statusline").setup {}
require("mini.diff").setup {}
