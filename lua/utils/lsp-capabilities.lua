local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), default_capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true

return capabilities
