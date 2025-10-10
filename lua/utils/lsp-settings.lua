-- LSP settings for mini.completion integration
local M = {}

-- General LSP Keymaps with LspAttach Autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local map = vim.keymap.set
    local bufnr = args.buf
    local function opts(desc)
      return { buffer = bufnr, silent = true, desc = "LSP - " .. desc }
    end

    map("n", "K", function()
      vim.lsp.buf.hover { border = "rounded" }
    end, opts "Hover information")

    map("n", "<C-k>", function()
      vim.lsp.buf.signature_help()
    end, opts "Signature help")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code Actions")
    map("n", "<leader>rn", vim.lsp.buf.rename, opts "Smart Rename")

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

    map("n", "<leader>sd", function()
      Snacks.picker.diagnostics_buffer()
    end, opts "Show Buffer Diagnostics")

    map("n", "<leader>sD", function()
      Snacks.picker.diagnostics()
    end, opts "Show diagnostics (all buffers)")

    map("n", "<leader>Dp", vim.diagnostic.goto_prev, opts "Go to previous diagnostic")
    map("n", "<leader>Dn", vim.diagnostic.goto_next, opts "Go to next diagnostic")
  end,
})

-- Disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

return M
