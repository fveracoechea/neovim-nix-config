-- LSP settings for mini.completion integration
local M = {}

-- Disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- Callback invoked when attaching a buffer to a language server.
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, silent = true, desc = "LSP - " .. desc }
  end

  local map = vim.keymap.set

  -- LSP information
  map("n", "<leader>lr", function()
    Snacks.picker.lsp_references()
  end, opts "References")

  map("n", "gd", function()
    Snacks.picker.lsp_definitions()
  end, opts "Definition")

  map("n", "<leader>li", function()
    Snacks.picker.lsp_implementations()
  end, opts "Implementation")

  map("n", "<leader>lt", function()
    Snacks.picker.lsp_type_definitions()
  end, opts "Type definition")

  -- Code Actions
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code Actions")

  -- Rename
  map("n", "<leader>rn", function()
    Snacks.rename()
  end, opts "Smart Rename")

  -- Updated to use snacks.picker for diagnostics
  map("n", "<leader>d", function()
    Snacks.picker.diagnostics_buffer()
  end, opts "Show buffer diagnostics")

  map("n", "<leader>D", function()
    Snacks.picker.diagnostics()
  end, opts "Show diagnostics (all buffers)")

  map("n", "[d", vim.diagnostic.goto_prev, opts "Go to previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, opts "Go to next diagnostic")
end

-- Used to enable autocompletion for mini.completion
-- Mini.completion works with default LSP capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
