local conform = require "conform"

local js_formatters = { "prettier", "deno_fmt", stop_after_first = true }

conform.setup {
  formatters = {
    prettier = {
      -- When cwd is not found, don't run the formatter (default false)
      require_cwd = true,
    },
  },
  formatters_by_ft = {
    javascript = js_formatters,
    typescript = js_formatters,
    javascriptreact = js_formatters,
    typescriptreact = js_formatters,
    css = js_formatters,
    html = js_formatters,
    json = js_formatters,
    jsonc = js_formatters,
    yaml = js_formatters,
    markdown = js_formatters,
    svelte = { "prettier" },
    graphql = { "prettier" },
    liquid = { "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
    nix = { "alejandra" },
  },
  format_on_save = {
    lsp_format = "never",
    timeout_ms = 1000,
  },
}
