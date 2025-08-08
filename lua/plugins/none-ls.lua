-- none-ls.nvim is a community-maintained replacement for null-ls
-- Configure code actions and diagnostics that aren't covered by conform.nvim and nvim-lint

local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    -- Diagnostics
    null_ls.builtins.diagnostics.codespell,

    -- Code Actions
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.code_actions.refactoring,
  },
}