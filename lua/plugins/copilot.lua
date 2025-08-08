require("copilot").setup {
  suggestion = {
    enabled = true,
    auto_trigger = true, -- Enable auto-trigger for better UX
    debounce = 100,
  },
  panel = {
    enabled = true, -- Enable panel for manual browsing
    auto_refresh = false, -- Don't auto-refresh to avoid conflicts
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>", -- Alt+Enter to open panel
    },
  },
  -- Disable copilot for certain filetypes to avoid conflicts
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
}
