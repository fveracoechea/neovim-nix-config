require("noice").setup {
  -- lsp = {
  --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --   override = {
  --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --     ["vim.lsp.util.stylize_markdown"] = true,
  --     ["cmp.entry.get_documentation"] = true,
  --   },
  -- },
  --

  -- Route notifications to snacks.notifier instead of noice's built-in notifier
  routes = {
    {
      view = "notify_send",
      filter = { event = "notify" },
    },
  },
}
