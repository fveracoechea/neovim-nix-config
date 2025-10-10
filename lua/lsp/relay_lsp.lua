local util = require "lspconfig.util"

---@type vim.lsp.Config
return {
  root_dir = util.root_pattern "relay.config.json",
}
