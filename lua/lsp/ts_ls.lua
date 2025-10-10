local util = require "lspconfig.util"

---@type vim.lsp.Config
return {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  single_file_support = false,
  root_dir = util.root_pattern("package.json", "tsconfig.json", "node_modules"),
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  handlers = {
    -- handle rename request for certain code actions like extracting functions / types
    ["_typescript.rename"] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ["end"] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
  commands = {
    ["editor.action.showReferences"] = function(command, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      local file_uri, position, references = unpack(command.arguments)

      local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
      vim.fn.setqflist({}, " ", {
        title = command.title,
        items = quickfix_items,
        context = {
          command = command,
          bufnr = ctx.bufnr,
        },
      })

      vim.lsp.util.show_document({
        uri = file_uri,
        range = {
          start = position,
          ["end"] = position,
        },
      }, client.offset_encoding)

      vim.cmd "botright copen"
    end,
  },
  on_attach = function(client, bufnr)
    -- Disable ts_ls if deno project detected
    if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
      if client.name == "ts_ls" then
        client.stop()
        return
      end
    end

    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, "source.")
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action {
        context = {
          only = source_actions,
        },
      }
    end, {})
  end,
}
