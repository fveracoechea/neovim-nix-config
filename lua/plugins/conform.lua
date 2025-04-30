local conform = require "conform"

local prettier = { "prettierd", "prettier", stop_after_first = true }

local js_formatters = function()
  if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
    return { "deno_fmt" }
  end

  return prettier
end

conform.setup {
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
    svelte = prettier,
    graphql = prettier,
    liquid = prettier,
    lua = prettier,
    python = { "isort", "black" },
    nix = { "alejandra" },
    ["*"] = { "codespell" },
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 1000,
  },
}
