require("noice").setup {
  lsp = {
    -- override markdown rendering so that **mini.completion** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      -- Removed cmp reference since we use mini.completion
    },
  },
  presets = {
    bottom_search = false, -- do not use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  -- Route notifications to snacks.notifier instead of noice's built-in notifier
  routes = {
    {
      filter = { event = "notify" },
      view = "notify_send", -- This will use vim.notify which snacks.notifier handles
    },
  },
}
