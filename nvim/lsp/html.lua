local capabilities = require "utils.lsp-capabilities"

---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
