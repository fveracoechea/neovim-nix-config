local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.codespell,

    null_ls.builtins.code_actions.proselint,

    null_ls.builtins.code_actions.refactoring,
  },
}
